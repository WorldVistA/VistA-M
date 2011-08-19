DVBAUTL5 ;ALB/JLU;UTILITY ROUTINE;9/13/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
SELECT(PAR1,PAR2) ;
 ;This function call will ask the user whether they want to select
 ;by date range or name/ssn.  It will return a "D" for date range,
 ;"N" for name/ssn or a zero otherwise.  It will accept two inputs
 ;PAR1 is the title oposite the name /ssn example Date Range
 ;PAR2 is the option using this call exampl 21 day certificate
 ;
 S DIR(0)="SOM^N:Patient Name/SSN;D:"_PAR1
 S DIR("B")="N",DIR("A")="Select "_PAR2_" by"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) D SK Q 0
 D SK
 Q Y
 ;
SK ;
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q
 ;
PAT(WHO) ;this entry point allows a patient lookup.
 ;the parameter WHO represents either MAS, RO OR NOONE
 ;
 S DIC="^DVB(396,",DIC(0)="AEMQZ"
 I $D(WHO) DO
 .I WHO="RO" S DIC("S")="I $D(^(4)),$P(^(4),U,4)]"""",$D(^(2)),$P(^(2),U,10)'=""L"",$D(^DPT($P(^(0),U,1),0))"
 .I WHO="MAS" S DIC("S")="I $P(^(0),U,14)]"""",$D(^(4)),$D(^(2)),$P(^(2),U,10)'=""L"",$D(^DPT($P(^(0),U,1),0))"
 .I WHO="MAS"!(WHO="RO") S DIC("W")="W ?32,""Original processing date "" N Y S Y=$S(WHO=""RO"":$P(^(4),U,4),1:$P(^(0),U,14)) D DD^%DT W Y"
 .I WHO=7131 S DIC("W")="I $D(^(1)) N Y S Y=$P(^(1),U) D DD^%DT W ""   on "",Y S Y=$G(^(2)) I Y]"""" W ""   "",$S($P(Y,U,10)=""A"":""Adm."",1:""Act.""),""  Req. by "",$P(Y,U,8)"
 .Q
 D ^DIC
 K DIC
 Q $P(Y,U,1)
