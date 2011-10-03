YTALUSEC ;ALB/ASF TEST-AUDIT ALCOHOL SCREEN CONDENSED ;8/6/03  11:40
 ;;5.01;MENTAL HEALTH;**54,70**;Dec 30, 1994
SCOR ;changed 8/6/03 ASF added year
 S YSTY="W*",YSNOITEM="DONE^YTALUSEC"
 D ^YTREPT
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 I YSED>3030811 W !!,"** Please interpret carefully. Wording changed since administration. **"
 W !!,"1. How often did you have a drink containing alcohol in the past year?"
 S R=$E(X,1)
 W !?7,">> ",$S(R=0:"Never",R=1:"Monthly or less",R=2:"Two to four times a month",R=3:"Two to three times per week",R=4:"Four or more times a week",1:"??")
 W !!,"2. How many drinks containing alcohol did you have on a typical day when"
 W !?3,"you were drinking in the past year?"
 S R=$E(X,2)
 W !?7,">> ",$S(R=0:"1 or 2",R=1:"3 or 4",R=2:"5 or 6",R=3:"7 to 9",R=4:"10 or more",1:"??")
 W !!,"3. How often did you have six or more drinks on one occasion",!?3,"in the past year"
 S R=$E(X,3)
 W !?7,">> ",$S(R=0:"Never",R=1:"Less than monthly",R=2:"Monthly",R=3:"Weekly",R=4:"Daily or almost daily",1:"??")
DONE QUIT
