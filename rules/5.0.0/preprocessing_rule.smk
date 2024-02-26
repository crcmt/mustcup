rule preprocessing:
	input:
		rules.normalization.output

	output:
		"{basedir}/{analysis}/preprocessing/{method}/samples.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_{method}_preprocessing.log"

	shell:
		"""
		{script_dir}/preproc_{wildcards.method} {input} {output} >> {log} 2>&1
		"""