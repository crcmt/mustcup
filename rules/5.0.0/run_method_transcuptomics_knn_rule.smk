rule run_method_transcuptomics_knn:
	input:
		"{basedir}/{analysis}/preprocessing/transcuptomics_knn/samples.txt"

	output:
		"{basedir}/{analysis}/run_method/transcuptomics_knn/predictions.txt"
	
	params:
		classifier = config['transcuptomics']["CLASSIFIER"]
	
	log:
		"{basedir}/{analysis}/log/{analysis}_transcuptomics_knn_run_method.log"

	shell:
		"""
		{script_dir}/launch_transcuptomics_knn {input} {params.classifier} $(dirname {output}) >> {log} 2>&1
		"""
