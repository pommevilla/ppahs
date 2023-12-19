rule raxml:
    input:
        "panaroo_outputs/derepped_{core_threshold}/core_gene_alignment.aln"
    output:
        "raxml_outputs/{core_threshold}/RAxML_parsimonyTree.{core_threshold}"
    log:
        out="logs/raxml/{core_threshold}/raxml.out",
        err="logs/raxml/{core_threshold}/raxml.err"
    conda:
        "../envs/raxml.yml"
    params:
        outdir="raxml_outputs/{core_threshold}"
    shell:
        """
        mkdir -p {params.outdir}
        raxmlHPC -p 123 \
            -m GTRGAMMA \
            -n {wildcards.core_threshold} \
            -s /project/fsepru/paul.villanueva/repos/ppahs/panaroo_outputs/derepped_{wildcards.core_threshold}/core_gene_alignment.aln \
            -w /project/fsepru/paul.villanueva/repos/ppahs/raxml_outputs/{wildcards.core_threshold}
        """

rule ppanggolin_trees:
    input:
        "outputs/ppanggolin_outputs/{version}derepped/{partition}_genome_alignment.aln"
    output:
        "outputs/raxml_outputs/ppanggolin_trees/{version}derepped/{partition}/RAxML_parsimonyTree.{partition}"
    log:
        out="logs/ppanggolin_trees/{version}derepped/{partition}/raxml.out",
        err="logs/ppanggolin_trees/{version}derepped/{partition}raxml.err"
    conda:
        "../envs/raxml.yml"
    params:
        outdir="outputs/raxml_outputs/ppanggolin_trees/{version}derepped/{partition}",
        basedir="/project/fsepru/paul.villanueva/repos/ppahs"
    wildcard_constraints:
        version=".*"
    shell:
        """
        mkdir -p {params.outdir}
        raxmlHPC -p 489 \
            -m PROTGAMMAWAG \ 
            -s {params.basedir}/outputs/ppanggolin_outputs/{wildcards.version}derepped/{wildcards.partition}_genome_alignment.aln \
            -w {params.basedir}/outputs/raxml_outputs/ppanggolin_trees/{wildcards.version}derepped/{wildcards.partition} \
            -n {wildcards.partition}
        """
