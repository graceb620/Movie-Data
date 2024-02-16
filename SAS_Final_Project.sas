/* 1. Importing data from files into SAS tables */
proc import datafile = "/home/u62174016/data_TV.csv" dbms = csv out = data_TV;
run;

/* 2&3. Use PROC MEANS steps to display the statistical properties of data */
title "Television Show Statistics";
proc means data = data_TV;
run;

/* 3&4. Use PROC CONTENTS steps to display important attributes of your data */
title "Television Shows";
proc contents data= data_TV;
run;

/* 6. Use PROC FREQ steps to generate frequency tables. */
proc freq data= data_TV;
	tables origin_country;
run;

/* 7&8. Demonstrate filtering of the data using the WHERE statement. */
data popular_data_TV;
	set data_TV;
	drop overview;
	where popularity >= 7;
run;

/* 5. Use PROC PRINT steps (with formatting) to output your data in a way that is
different than the default. */
proc print data= popular_data_TV;
	var popularity vote_average vote_count name;
	format popularity vote_count COMMA15.;
run;

/* 9. USE PROC SORT to reveal the minimum or maximum row of a variable in your data. */
proc sort data= data_TV out= sorted_data_TV;
	by descending popularity;
run;

/* 10. Create a new (small) dataset using DATALINES. */
data Country_NumShows;
	input Country $ Number of Shows;
	datalines;
	United States English 1377
	Japan Japanese 393
	Korea Korean 98
	Mexico Spanish 148
	;
run;

data Language; 
	input Country $ Language;
	datalines;
	United States English
	Japan Japanese
	Korea Korean
	Mexico Spanish
	;
run;	

/* 11. Combine two datasets using the MERGE statement. */
proc sort data=Country_NumShows;
	by Country;
run;

proc sort data=Language;
	by Country;
run;

data Country_Data;
	merge Country_NumShows Language;
	by Country;
run;

/* 12. Demonstrate conditional processing in SAS (using if statements). */
data new_TV_data;
	length origin_country $ 20 vote_count 8 Vote_Category $ 12;
	set data_TV;
if vote_count < 20 then Vote_Category = "Flop";
else if vote_count < 100 then Vote_Category = "Minor Success";
else if vote_count < 200 then Vote_Category = "Blockbuster";
else Vote_Category = "Super hit";
keep origin_country vote_count Vote_Category;
run;

proc print data = new_TV_data;
run;

proc freq data = new_TV_data order=freq;
 tables Vote_Category / plot = freqplot;
run;

/* 13. Create visualizations using different charts (at least two). */
data countries_plot;
	set data_TV;
	where origin_country in ("US", "JP","FR","DE","CA","NZ","KR","GB","ES","MX");
run;

proc sgplot data= countries_plot;
	vbar vote_average / GROUP= origin_country;
	title "Distribution of Vote Averages based on Origin Countries";
run;


data language_plot;
	set data_TV;
	where origin_country in ("US", "JP","FR","DE","CA","NZ","KR","GB","ES","MX");
run;

proc sgplot data= language_plot;
	vbar origin_country / GROUP= original_language;
	title "Distribution of Language based on Origin Countries";
run;

	







	






