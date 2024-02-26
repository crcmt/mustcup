rule report:
	input:
		expand(rules.label_standardisation.output, basedir=basedir, analysis=analysis, method=methods)

	output:
		"{basedir}/{analysis}/report/report.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_report.log"
	
	params:
		input_formatting_output = rules.input_formatting.output

	shell:
		"""
		mustcup_sample_name_dir=$(dirname {params.input_formatting_output})
		sample_name=$(cat $mustcup_sample_name_dir/mustcup_sample_name)
		{script_dir}/build_report $sample_name {output} {input} >> {log} 2>&1
		"""
