rule run_method_transcuptomics:
	input:
		"{basedir}/{analysis}/preprocessing/transcuptomics/samples.txt"

	output:
		"{basedir}/{analysis}/run_method/transcuptomics/predictions.txt"
	
	params:
		classifier = config['transcuptomics']["CLASSIFIER"]
	
	log:
		"{basedir}/{analysis}/log/{analysis}_transcuptomics_run_method.log"

	shell:
		"""
		{script_dir}/launch_transcuptomics {input} {params.classifier} $(dirname {output}) >> {log} 2>&1
		"""
