import glob
import os

INPUT_DIRECTORY = config['directories']['genome_input_directory']

INPUT_FILES = [os.path.basename(fin) for fin in glob.glob(f"{INPUT_DIRECTORY}/*")]

CORE_GENOME_THRESHOLDS = config['panaroo']['core_thresholds']

VERSIONS = ["not_", ""]
PARTITIONS = ["cloud"]
