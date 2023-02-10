	
inputDialogs = LOAD 'hdfs:///user/sushma/inputs' USING PigStorage('\t') AS (name:chararray, line:chararray);

ranked = RANK inputDialogs;
OnlyDialogs = FILTER ranked BY (rank_inputDialogs > 2);
		
groupByName = GROUP OnlyDialogs BY name;

names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;

STORE namesOrdered INTO 'hdfs:///user/root/outputs' USING PigStorage('\t');