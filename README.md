# R_NBA-Grit
Explores whether "Hustle Stats" have any correlation with wins/player value

To view the full write up: https://github.com/tbala25/R_NBA-Grit/blob/master/BALA_T_report.pdf

Key Points:

This	report	will	explore	professional	basketball	statistics	to	try	to	find	how	much	truth	is	in	the	
day	old	mantra	ringing	through	gyms	across	the	country,	“hustle	wins	games.”	I	have	recorded	
a	journal	throughout	this	process	so	you	will	be	able	to	read	about my	trials	and	triumphs	with	
each	step	along	with the	results	and justification for	that	step.

The	data	was	scraped	from	the	National	Basketball	Association’s	statistics	portion	of	the	site.	I	
used	import.io	to	scrape	data	from	three	different	tables:	Traditional	Team	Stats,	Player	Hustle	
Stats,	and	Player	Tracking	Rebounding	Stats.	Since	the	question	was	about	hustle	on	the	court	
the	Hustle	Stats	table	was	an	obvious	and	was	the	NBA’s	best	collection	of	data	for	an	
otherwise	immeasurable	characteristic.	I	added	the	Rebound	Table	because	I	felt	that	the	
statistic	for	Contested	Rebounds	also	demonstrated	“grit”.	

Calculating	GRIT
When	I	first	scraped	the	data	I	was	just	playing	with	coming	up	with	an	all-encompassing	metric	
for	hustle.	I	created	arbitrary	weights	for	each	statistic	based	on	how	often	I	felt	it	could	
happen,	how	impactful	it	is	in	the	game and	trying	not	to	overweight	the	work	of	a	forward	or	
center	versus	a	guards.	I	came	up	with	this	formula	for	GRIT:
GRIT = (Screen Assists) + 2(Deflections) + 3(Looseballs Recovered) +
3(Charges Drawn) + (Contested 2FG) + 2(Contested 3FG)
I	also	decided	to	make	a	normalized	GRIT	statistic	which	projected	each	players’	GRIT	score	as	if	
they	played	a	full	48	minutes.	In	retrospect	this	number	should	have	been	far	closer	to	30	which	
is	around	the	average	minutes	that	starters	will	play	in	a	game.
Originally my	GRIT	score	calculation	was	incorrect	and	I	could	tell	because	naturally	a	starter	
and	a	big-man	would	have	a	higher	GRIT	score	than	a	reserve	guard	and	this	was	not	true.	
