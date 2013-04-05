YS103PRE ;HIOFO/FT - YS*5.01*103 PRE-INIT ; 2/7/11 11:54am
 ;;5.01;MENTAL HEALTH;**103**;Dec 30, 1994;Build 27
 ;Reference to XPDGREF and ^XTMP supported by DBIA #2433
MAIN ;Main entry
 D EN1,EN1A,EN1B,EN2,EN3,EN4
 Q
EN1 ;MH CHOICES (601.75)
 ;Delete CHOICE TEXT (field #3) for selected entries because these
 ;entries have embedded control characters or spelling errors or 
 ;punctuation errors. 
 ;The KIDS build will add the correct value.
 N YSARR,YSFDA,YSIEN
 F YSIEN=569,602,645,1012,1021,1378,1379,1633,1800,1865,1921,1952,1969,1982,1986,1989,2007,2020,2027,2033,2036,2068,2133,2140,2241,2242,2248,2249,2375,2439,2517,2583,2626,2702,2703,2884 D
 .K YSFDA,YSARR
 .S YSFDA(601.75,YSIEN_",",3)="@"
 .D UPDATE^DIE("","YSFDA","YSARR")
 Q
EN1A ;MH TESTS AND SURVEYS (601.71)
 ;Delete PURPOSE (field #12) for selected entry because it has embedded control characters.
 ;The KIDS build will add the correct value.
 N YSARR,YSFDA
 S YSFDA(601.71,47_",",12)="@"
 D UPDATE^DIE("","YSFDA","YSARR")
 Q
EN1B ;MH QUESTIONS (601.72)
 ;Delete QUESTION TEXT (field #1) for selected entry because it has embedded control characters.
 ;The KIDS build will add the correct value.
 N YSARR,YSFDA
 S YSFDA(601.72,5016_",",1)="@"
 D UPDATE^DIE("","YSFDA","YSARR")
 Q
EN2 ;MH SCALEGROUPS (601.86)
 ;Modifies one entry. This is an existing entry, but the SCALEGROUP NAME
 ;which is an IDENTIFIER has changed. 
 N YSARR,YSFDA
 S YSFDA(601.86,"134,",2)="Part I" ;SCALEGROUP NAME
 S YSFDA(601.86,"134,",4)="Score"  ;ORDINATE TITLE                       
 S YSFDA(601.86,"134,",7)=6        ;ORDINATEMAX
 D UPDATE^DIE("","YSFDA","YSARR")
 Q
EN3 ;MH SCALES (601.87)
 ;Modifies two entries. These are existing entries, but the SCALE NAME
 ;which is an IDENTIFIER has changed.
 N YSARR,YSFDA
 S YSFDA(601.87,"507,",3)="Interference" ;SCALE NAME
 S YSFDA(601.87,"507,",4)="Inter"        ;XLABEL
 D UPDATE^DIE("","YSFDA","YSARR")
 K YSARR,YSFDA
 S YSFDA(601.87,"508,",3)="Support" ;SCALE NAME
 S YSFDA(601.87,"508,",4)="Sup" ;XLABEL
 D UPDATE^DIE("","YSFDA","YSARR")
 K YSARR,YSFDA
 S YSFDA(601.87,"580,",3)="Confidence in No Use" ;SCALE NAME
 D UPDATE^DIE("","YSFDA","YSARR")
 Q
EN4 ;delete C & AU x-refs on file 601.75, field 3
 ;Both x-refs will be re-built with the installation.
 N YSARR,YSCHK,YSEMSG,YSERR,YSX
 D FIND^DIC(.11,"",".01;.02;.11","CPX","601.75","*","B","","","YSCHK","YSEMSG") ;check if indexes already exist
 I $G(YSEMSG("DIERR",1,"TEXT",1)) D  Q
 .S YSARR(1)=YSEMSG("DIERR",1,"TEXT",1)
 .S YSARR(2)="Please log a Remedy ticket."
 .D EN^DDIOL(.YSARR)
 I $P(YSCHK("DILIST",0),U,1)="3" Q  ;new indexes already created.
 D DELIX^DDMOD(601.75,3,1,,,"YSERR") ;delete C x-ref definition
 I +$P($G(YSERR("DIERR")),U,1)>0 D
 .S YSX=$G(YSERR("DIERR",1,"TEXT",1))
 .D EN^DDIOL(YSX,,"!")
 D DELIX^DDMOD(601.75,3,2,,,"YSERR") ;delete AU x-ref definition
 I +$P($G(YSERR("DIERR")),U,1)>0 D
 .S YSX=$G(YSERR("DIERR",1,"TEXT",1))
 .D EN^DDIOL(YSX,,"!")
 Q
PRETRAN ;Pre-Transportation entry point
 ;Copy the MH CHOICETYPE (601.751) entries into the transport global
 N YSLOOP
 S YSLOOP=0
 F  S YSLOOP=$O(^YTT(601.751,YSLOOP)) Q:'YSLOOP!(YSLOOP>99999)  D
 .S @XPDGREF@(601.751,YSLOOP)=$G(^YTT(601.751,YSLOOP,0))
 Q
POST751 ;enter all MH CHOICETYPE (601.751) entries
 N N,DIK
 S N=0
 F  S N=$O(^XTMP("XPDI",XPDA,"TEMP",601.751,N)) Q:N'>0  D
 .S ^YTT(601.751,N,0)=^XTMP("XPDI",XPDA,"TEMP",601.751,N)
 S DIK="^YTT(601.751," D IXALL^DIK
 Q
