rule run_method_cuppa:
	input:
		"{basedir}/{analysis}/preprocessing/cuppa/samples.txt"

	output:
		"{basedir}/{analysis}/run_method/cuppa/predictions.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_cuppa_run_method.log"

	shell:
		"""
		{script_dir}/launch_cuppa {input} {output} {db_dir}/ref_data >> {log} 2>&1
		"""