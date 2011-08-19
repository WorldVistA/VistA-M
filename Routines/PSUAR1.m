PSUAR1 ;BIR/PDW - Start AR/WS Extract ;11 AUG 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;;
 ;PSUDTDA - IEN FOR DATE
 ;PSUSDA - IEN FOR INPATIENT SITE
 ;PSUDRDA - IEN FOR DRUG
 ;PSUCDA - IEN FOR CATEGORY
 ;PSUDIV - IEN FOR DIVISION OR "NONE"
 ;
 ;DBIAs
 ; Reference to file #58.5  supported by DBIA 456
 ; Reference to file #58.1  supported by DBIA 2515
 ; Reference to file #59.4  supported by DBIA 2498
 ; Reference to file #44    supported by DBIA 2439
 ; Reference to file #40.8  supported by DBIA 2438
 ; Reference to file #59    supported by DBIA 1876
 ; Reference to file #59.7  supported by DBIA 2854
 ;
EN ;EP MAIN ENTRY POINT
 ;
 K PSUTDSP,PSUTRET
 ;
START ;Start date scan thru stats file
 S PSUSDT=PSUSDT-.1
 S PSUDT=PSUSDT
 S PSUEDT=PSUEDT\1+.24
Q F  S PSUDT=$O(^PSI(58.5,"B",PSUDT)) Q:'PSUDT  Q:PSUDT>PSUEDT  D DATE Q:$G(PSUQUIT)
 Q
DATE ;PROCESS ONE DATE - Loop through inpatient sites
 S PSUDTDA=$O(^PSI(58.5,"B",PSUDT,0))
 K PSUSITE
 D GETM^PSUTL(58.5,PSUDTDA,"1*^.01","PSUSITE")
 S PSUSDA=0
 F  S PSUSDA=$O(PSUSITE(PSUSDA)) Q:PSUSDA'>0  D SITE Q:$G(PSUQUIT)
 K PSUSITE
 Q
 ;
SITE ;Process one site for one date
 ; Find division for site for loading drug stats
 S PSUDIV=$$DIV(PSUSDA,PSUDTDA)
 ;
 I PSUDIV="NULL" S PSUDIV=PSUSNDR
 ;
 ;    Process individual Drug information from 58.52
 ;    Drug multiple loaded into PSUDRUG
 K PSUDRUG
 D GETM^PSUTL(58.501,"PSUDTDA,PSUSDA","2*^.01","PSUDRUG")
 S PSUDRDA=0
 F  S PSUDRDA=$O(PSUDRUG(PSUDRDA)) Q:PSUDRDA'>0  D DRUG Q:$G(PSUQUIT)
 K PSUDRUG
 ;
 D MAP
 ;    Process Amis categories from 58.501
 ;    Category multiple loaded into PSUCAT
 K PSUCAT
CATEGORY ;EP Pull Categories
 K PSUAMCAT
 D GETM^PSUTL(58.501,"PSUDTDA,PSUSDA","1*^.01;1;2;3;4","PSUAMCAT","I")
 ;
 ;    Move (da,Fld,"I") values to (da,Fld) nodes
 D MOVEMI^PSUTL("PSUAMCAT")
 ;
 ;   Gather totals for categories and accumulate in
 ;   ^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"DISP":COST")
 N PSUDISP,PSUCOST
 S PSUCDA=0 F  S PSUCDA=$O(PSUAMCAT(PSUCDA)) Q:PSUCDA'>0  D
 . S PSUDISP=PSUAMCAT(PSUCDA,1)-PSUAMCAT(PSUCDA,3)
 . S PSUCOST=PSUAMCAT(PSUCDA,2)-PSUAMCAT(PSUCDA,4)
 . S PSUAMCAT=PSUAMCAT(PSUCDA,.01) ; "03"-"04"-"06" etc
 . S X=$G(^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"DISP"))
 . S ^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"DISP")=X+PSUDISP
 . S X=$G(^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"COST"))
 . S ^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"COST")=X+PSUCOST
 . M ^XTMP("PSUTCST",PSUDIV,PSUAMCAT)=^XTMP(PSUARSUB,"DIV_CAT",PSUDIV,PSUAMCAT,"COST")
 ;
 Q
 ;
DRUG ;  Process one drug for one site for one day
 ;  Load & loop categories within Drug
 ;  total dispense & returns
 ;  Category multiple loaded into PSUCAT
 ;
 S PSUDRIEN=$$VALI^PSUTL(58.52,"PSUDTDA,PSUSDA,PSUDRDA",.01)
 K PSUCAT
 D GETM^PSUTL(58.52,"PSUDTDA,PSUSDA,PSUDRDA","1*^.01;1","PSUCAT","I")
 ;
 S PSUCDA=0,PSUDISP=0,PSUTR=0
 F  S PSUCDA=$O(PSUCAT(PSUCDA)) Q:PSUCDA'>0  Q:$G(PSUQUIT)  D
 . S X=PSUCAT(PSUCDA,.01,"I")
 . S Y=PSUCAT(PSUCDA,1,"I")
 . I (X="A")!(X="W") S PSUDISP=PSUDISP+Y,PSUTDS=PSUDISP
 . I (X="RA")!(X="RW") S PSUDISP=PSUDISP-Y,PSUTR=PSUTR+Y
 ;  Adjust accumulative dispenses
 ;
 S X=$G(^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV,PSUDRIEN))
 S ^XTMP(PSUARSUB,"DIV_DRUG",PSUDIV,PSUDRIEN)=X+PSUDISP
 ;
 N PSUT
 S PSUT=$G(PSUTDSP(PSUDIV,PSUDRIEN))
 I $D(PSUTDS) D
 .S PSUTDSP(PSUDIV,PSUDRIEN)=PSUTDS+PSUT    ;Total Quantity dispensed
 .I (PSUTDS+PSUT)=0 S PSUTDSP(PSUDIV,PSUDRIEN)=""
 ;
 N PSUT1
 S PSUT1=$G(PSUTRET(PSUDIV,PSUDRIEN))
 I $D(PSUTR) D
 .S PSUTRET(PSUDIV,PSUDRIEN)=PSUTR+PSUT1    ;Total Quantity returned
 .I (PSUTR+PSUT1)=0 S PSUTRET(PSUDIV,PSUDRIEN)=""
 K PSUCAT
 Q
DIV(PSUSDA,PSUDTDA) ;EP process for a site the associated divisions by date.
 ; uses PSUSDA as entry for site ien in file 59.4 : returns division
 ; as of 2/99 date is no longer used as a parameter
 N PSUDIV,PSUDT
 I '$D(^XTMP(PSUARSUB,"DIVLK",PSUSDA)) D AOU
 ; ^XTMP(PSUARSUB,"DIVlk",Site IEN, AOU Inactive Date -1)=Division IEN
 ;
 ; if AOU did not set division then return null 
 I '$D(^XTMP(PSUARSUB,"DIVLK",PSUSDA)) S PSUDIV="NULL" Q PSUDIV
 ;
 S PSUDIV=$O(^XTMP(PSUARSUB,"DIVLK",PSUSDA,""))
 Q PSUDIV
 ;
AOU ;EP map divisions by dates for  inpatient sites from the AOU file
 ;PSUADA - ien for AOU Stock file
 ;
 N PSUADA,PSUDIV,PSUINACT,PSUDIV,PSUSLOC,MAPLOCI
 ;
 D GETM^PSUTL(59.7,1,"90.01*^.01;.02;.03","MAPLOCI","I")
 ;set array MAPLOCI(ien,fld)=internal value
 ;field .02 points to 40.8 Medical Center Division where fac num is #1
 ;field .03 points to 59 Outpatient site where site num is #.06
 D MOVEMI^PSUTL("MAPLOCI")
 ;
 K ^XTMP(PSUARSUB,"DIVLK")
 ;
 S PSUADA=0
 F  S PSUADA=$O(^PSI(58.1,"ASITE",PSUSDA,PSUADA)) Q:PSUADA'>0  D
 . N PSUDIV S PSUDIV=""
 . S PSUSLOC=$$VALI^PSUTL(59.4,PSUSDA,.01)
 . S PSUINACT=$$VALI^PSUTL(58.1,PSUADA,3)
 . I PSUINACT Q  ; inactivated sites are to be ignored regardles of date
 . S:'PSUINACT PSUINACT=DT+1
 . I '$G(MAPLOCI(PSUADA,.01)) S PSUDIV="NULL"
 . I $G(MAPLOCI(PSUADA,.01)) D
 .. S X=$G(MAPLOCI(PSUADA,.02)) I X S PSUDIV=$$VALI^PSUTL(40.8,X,1)
 .. S X=$G(MAPLOCI(PSUADA,.03)) I X S PSUDIV=$$VALI^PSUTL(59,X,.06)
 .. S ^XTMP(PSUARSUB,"DIVLK",PSUSDA,PSUDIV)=""
 ;
 Q
 ;
MAP ;Find out whether an Area of Use (AOU) is mapped to a division or
 ;outpatient site.  If it is not mapped, store the NAME and INACTIVATION
 ;DATE (if applicable) in a global to be mailed to the user.
 ;
 S PSUNAM=0                         ;This is the name of the Area of USE
 ;
 F  S PSUNAM=$O(^PSI(58.1,"B",PSUNAM)) Q:PSUNAM=""  D
 .S IEN=0                        ;This is the IEN for file 58.1
 .F  S IEN=$O(^PSI(58.1,"B",PSUNAM,IEN)) Q:IEN=""  D
 ..K AOU
 ..D GETS^PSUTL(58.1,IEN,".01;3","AOU(IEN)")  ;Name & Inactive Date
 ..D MAP1
 Q
 ;
MAP1 ;MAP continued. This subroutine takes the IEN from file 58.1 and looks
 ;to see if it is in file 59.7, field 90.01.  If it is, then it has
 ;been mapped if there is a value in subfield .02 or .03.
 ;If there is no value in subfield .02 or .03 it has not been mapped
 ;
 ;Keep only the entries that are NOT mapped
 ;
 N PSUDA
 ;
 I $G(^PS(59.7,1,90.01,IEN,0)) D
 .D GETM^PSUTL(59.7,1,"90.01*^.01;.02;.03","MAPLOCI")
 .S PSUDA=0
 .F  S PSUDA=$O(MAPLOCI(PSUDA)) Q:PSUDA=""  D
 ..I MAPLOCI(PSUDA,.02)'="" K AOU(PSUDA)
 ..I $G(MAPLOCI(PSUDA,.03))'="" K AOU(PSUDA)
 M ^XTMP(PSUARSUB,"AOU")=AOU          ;Contains only unmapped locations
 Q
 ;
CLEAR ;EP Clear ^XTMP("PSUAR*")
 S X="PSUAR",Y=X
 F  S Y=$O(^XTMP(Y)) Q:($E(Y,1,5)'=X)  W !,Y K ^XTMP(Y)
 Q
