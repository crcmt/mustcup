rule format_standardisation:
	input:
		"{basedir}/{analysis}/run_method/{method}/predictions.txt"

	output:
		"{basedir}/{analysis}/format_standardisation/{method}/predictions.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_{method}_format_standardisation.log"

	shell:
		"""
		{script_dir}/fmt_normalize_{wildcards.method} {input} {output} >> {log} 2>&1
		"""
