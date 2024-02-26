rule normalization:
	input:
		rules.input_formatting.output

	output:
		"{basedir}/{analysis}/normalization/{method}/samples.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_{method}_normalization.log"

	shell:
		"""
		{script_dir}/get_normalized_data.R {input} {output} {wildcards.method} {db_dir} >> {log} 2>&1
		"""