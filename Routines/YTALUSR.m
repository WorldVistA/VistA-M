YTALUSR ;ALB/ASF TEST-AUDIT ALCOHOL SCREEN CONDENSED REVISED ;7/14/00  12:31
 ;;5.01;MENTAL HEALTH;**66**;Dec 30, 1994
SCOR ;
 S YSTY="W*",YSNOITEM="DONE^YTALUSR"
 D ^YTREPT
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 W !!,"1. How often did you have a drink containing alcohol in the past year?"
 S R=$E(X,1)
 W !?7,">> ",$S(R=0:"Never",R=1:"Monthly or less",R=2:"Two to four times a month",R=3:"Two to three times per week",R=4:"Four or more times a week",1:"??")
 W !!,"2. How many drinks containing alcohol did you have on a typical day when"
 W !?3,"you were drinking in the past year?"
 S R=$E(X,2)
 W !?7,">> ",$S(R=0:"0 drinks",R=1:"1 or 2",R=2:"3 or 4",R=3:"5 or 6",R=4:"7 to 9",R=5:"10 or more",1:"??")
 W !!,"3. How often did you have six or more drinks on one occasion in the past year?"
 S R=$E(X,3)
 W !?7,">> ",$S(R=0:"Never",R=1:"Less than monthly",R=2:"Monthly",R=3:"Weekly",R=4:"Daily or almost daily",1:"??")
DONE QUIT
