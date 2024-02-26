rule input_formatting:
	input:
		"{basedir}/star_table_count/{analysis}.tsv"

	output:
		"{basedir}/{analysis}/input_formatting/samples.txt"
	
	log:
		"{basedir}/{analysis}/log/{analysis}_input_formatting.log"

	shell:
		"""
		output_dir=$(dirname {output})

		# store the sample name for later use (in 'report' rule)
		sample_name=$(head -1 {input} | cut -f2)
		echo $sample_name > $output_dir/mustcup_sample_name

		{script_dir}/format.sh {input} {output} >> {log} 2>&1
		"""