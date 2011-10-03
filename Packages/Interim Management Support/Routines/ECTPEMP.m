ECTPEMP ;B'ham ISC/PTD-Employee Inquiry ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**11,16**;
 ;ROUTINE PULLS DATA FROM FILE 450 - CURRENT EMPLOYEE AND FROM FILE 200 - NEW PERSON
 I '$D(^PRSPC) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Current Employee' File - #450 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^PRSPC(0)) W *7,!!,"'Current Employee' File - #450 has not been populated on your system.",!! S XQUIT="" Q
DIC W !! S DIC="^PRSPC(",DIC(0)="QEANMZ",DIC("A")="Select EMPLOYEE name: " D ^DIC K DIC G:Y<0 EXIT S EMPDA=+Y
 S NM=Y(0,0),SCD=$P(Y(0),"^",31),EMPSN=$P(Y(0),"^",9)
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP W @IOF,!!?33,"EMPLOYEE DATA:",!,"NAME: ",NM,! I EMPSN="" W *7,"Employee SSN is missing in 'Current Employee' - File #450." K Y,NM,EMPSN G DIC
 I SCD'="" W !?2,"Service Computation Date: " S Y=SCD D DD^%DT W Y
 I $D(^PRSPC(EMPDA,0)) S SAL=$P(^PRSPC(EMPDA,0),"^",29) I SAL'="" W !?2,"Salary: " S X=SAL,X2="2$" D COMMA^%DTC W X
 I $D(^PRSPC(EMPDA,0)) S TITL=$P(^PRSPC(EMPDA,0),"^",17) I (TITL'=""),($O(^PRSP(454,1,"OCC","B",TITL,0))) S OCCDA=$O(^PRSP(454,1,"OCC","B",TITL,0)) W !?2,"Title: ",$P(^PRSP(454,1,"OCC",OCCDA,0),"^",2)
 I '$D(^VA(200,"SSN",EMPSN)) W !!?25,"NO ADDITIONAL DATA AVIALABLE.",!,"Employee SSN is not listed in file #200." K Y,NM,EMPSN G DIC
200 S PRSNDA=$O(^VA(200,"SSN",EMPSN,0)),DOB=$P(^VA(200,PRSNDA,1),"^",3)
 S DIC="^VA(200,",DA=PRSNDA,DR="5;.13;.11" D EN^DIQ K DIC,DA,DR S Y=DOB W:DOB'="" !?2,"BIRTH DATE: " D:DOB'="" DT^DIQ G DIC
EXIT K %,A,C,D0,DOB,EMPDA,EMPSN,NM,OCCDA,POP,PRSNDA,S,SAL,SCD,SN,TITL,X,X2,Y
 Q
 ;
