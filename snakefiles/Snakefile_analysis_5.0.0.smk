workdir: config["general_path"]["DIR_PATH"]
basedir = config["general_path"]["BASEDIR"]
conf_path = config["general_path"]["CONF_PATH"]
script_dir = config["general_path"]["SCRIPT_DIR"]
db_dir = config["general_path"]["DB_DIR"]
export_dir = config["general_path"]["EXPORT_PATH"]
rule_path = config["general_path"]["SNAKEMAKE_RULES"]

import os
directory = "/scratch3/spim/test_mustcup/star_table_count"
analysis_all = [os.path.splitext(filename)[0] for filename in os.listdir(directory)]


def split_list(lst):
    sublist_size = len(lst) // 10
    remainder = len(lst) % 10
    sublists = []
    start = 0
    for i in range(10):
        end = start + sublist_size + (1 if i < remainder else 0)
        sublists.append(lst[start:end])
        start = end
    return sublists

sublists = split_list(analysis_all)
#analysis = sublists[0]


analysis = analysis_all
#analysis = ["A00651_0188_WGS_cancer_2FF60_03082023",
#"A00651_0188_WGS_cancer_2FF60_13072023", "A00651_0188_WGS_cancer_10D60_29112021", "A01293_0193_WGS_cancer_16880_31032022", "A01293_0371_WGS_cancer_28A20_24042023", "A01554_0143_WGS_cancer_22A30_17012023"
#]

methods = [
#'cupaidx',
#'v1_rm500', 'v1_rm500dropout',
'cuppa', 'transcuptomics'
]

include : rule_path+"/input_formatting_rule.smk"
include : rule_path+"/normalization_rule.smk"
include : rule_path+"/preprocessing_rule.smk"
include : rule_path+"/run_method_cuppa_rule.smk"
include : rule_path+"/run_method_transcuptomics_rule.smk"
include : rule_path+"/format_standardisation_rule.smk"
include : rule_path+"/label_standardisation_rule.smk"
include : rule_path+"/report_rule.smk"

rule all:
	input:
		expand(rules.report.output, basedir=basedir, analysis=analysis, method=methods)
