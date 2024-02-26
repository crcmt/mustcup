rule label_standardisation:
	input:
		pred = rules.format_standardisation.output

	output:
		"{basedir}/{analysis}/label_standardisation/{method}/predictions.txt"

	params:
		label_map = lambda wildcards: f"{db_dir}/reference_labels.tsv"


	log:
		"{basedir}/{analysis}/log/{analysis}_{method}_label_standardisation.log"

	shell:
		"""
		{script_dir}/label_normalize {input.pred} {params.label_map} {wildcards.method} {output} >> {log} 2>&1
		"""
