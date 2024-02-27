rule run_method_transcuptomics_rf:
	input:
		"{basedir}/{analysis}/preprocessing/transcuptomics_rf/samples.txt"

	output:
		"{basedir}/{analysis}/run_method/transcuptomics_rf/predictions.txt"
	
	params:
		classifier = config['transcuptomics']["CLASSIFIER"]
	
	log:
		"{basedir}/{analysis}/log/{analysis}_transcuptomics_rf_run_method.log"

	shell:
		"""
		{script_dir}/launch_transcuptomics_rf {input} {params.classifier} $(dirname {output}) >> {log} 2>&1
		"""
