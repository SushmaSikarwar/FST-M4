	
inputFile = LOAD 'hdfs:///user/sushma/file01.txt' AS (line);	
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;	
grpd = GROUP words BY word;	
cntd = FOREACH grpd GENERATE group, COUNT(words);

rmf hdfs:///user/root/file01.txt;	
	
STORE cntd INTO 'hdfs:///user/root/results';