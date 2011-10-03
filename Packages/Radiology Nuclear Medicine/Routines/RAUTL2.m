RAUTL2 ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Utility Routine ;11/10/97  11:18
 ;;5.0;Radiology/Nuclear Medicine;**10,26,45**;Mar 16, 1998
 ;
 ;Called from many points within Rad/Nuc Med package ;ch
 ;INPUT VARIABLES:  Y=IEN of Rad Report file #74
 ;  XRT0,XRT1 If set, will do some response time checks
 ;OUTPUT VARIABLES:
 ;  RADFN=Patient DFN, RADTE=Exam date/time (FM format), 
 ;  RACN=long case number, RADTI=reverse exam date/time,
 ;  RACNI=short case number, RADATE=Exam date/time (external format)
 ;  Y=If active case, zeroeth node of case record in file #70
RASET D:$D(XRTL) T0^%ZOSV S Y=$S($D(^RARPT(+Y,0)):^(0),1:"") Q:'Y  S RADFN=+$P(Y,"^",2),RADTE=+$P(Y,"^",3),RACN=+$P(Y,"^",4),RADTI=9999999.9999-RADTE,RACNI=$O(^RADPT("ADC",$P(Y,"^"),RADFN,RADTI,0)) S Y=RADTE D D^RAUTL S RADATE=Y
 S Y="" I RACNI,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S Y=^(0)
 I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV
 Q
 ;
 ;Called from 2 x-refs on file #74, Rpt Status fld 5 ;ch
 ;Does sets and kills for  'ARES', and 'ASTF' xrefs
 ; ** CAUTION ** 1st RARAD=12 or 15, 2nd RARAD=ien for file 200
XREF Q:'$D(^RARPT(DA,0))  S RADFNZ=^(0),RADTIZ=9999999.9999-$P(RADFNZ,"^",3),RACNIZ=$O(^RADPT(+$P(RADFNZ,"^",2),"DT",RADTIZ,"P","B",+$P(RADFNZ,"^",4),0)),RADFNZ=+$P(RADFNZ,"^",2),RADA=DA G Q:'RACNIZ
 S RARADOLD=RARAD ;save 1st value of rarad
 G Q:'$D(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,0)) S RARAD=+$P(^(0),"^",RARAD) G Q:'RARAD
 ; ** CAUTION ** next line is reached 2 ways : from line above,
 ;    and also from file 70.03, fld 15's "ASTF" xref
 ;    thus RARAD's 2nd meaning must be preserved for XREF1
XREF1 S:$D(RASET) ^RARPT(RAXREF,RARAD,RADA)="" K:$D(RAKILL) ^RARPT(RAXREF,RARAD,RADA) D XPRI^RAUTL20
Q K RADA,RADFNZ,RADTIZ,RACNIZ,RARADOLD Q
 ;
 ;Checks for CONTRAST MEDIA given the necessary subscripts
 ;to access a record in File #70.
 ;RADFN, RADTI, RACNI must be set.
 ;Output is Y=a string delimited by commas containing all
 ;applicable items in externally formatted text (ex:  If exam was
 ;done with contrast media Y="CONTRAST MEDIA USED"
 ;06/16/99 remove obsolete RAF2
 ;         add CPT Modifiers string
 ; output Y = procedure modifiers string
 ;        Y(1)= CPT modifiers string, external
 ;        Y(2)= CPT modifiers string, internal
MODS ;get procedure modifiers
 S (Y,Y(1),Y(2))="" Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))  S X=^(0)
 F I=0:0 S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",I)) Q:I'>0  I $D(^RAMIS(71.2,+^(I,0),0)) S X1=$P(^(0),"^") D MODS1
 S:$P(X,"^",10)["Y" X1="CONTRAST MEDIA USED"
 ;
MODS0 ;falls through from MODS; get CPT modifiers
 S:Y="" Y="None"
 S X=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),I=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",I)) Q:I'>0  S X1=$$BASICMOD^RACPTMSC(+$G(^(I,0)),DT) I +X1>0 S Y(1)=Y(1)_$S(Y(1)="":"",1:", ")_$P(X1,"^",2),Y(2)=Y(2)_$S(Y(2)="":"",1:", ")_$P(X1,"^")
 S:Y(1)="" Y(1)="None"
 K I,X,X1 Q
 ;
MODS1 ;builds procedure modifier string (called from MODS above)
 S Y=Y_$S(Y="":"",1:", ")_X1 Q
 ;
 ;called to do some order checks - takes appropriate action if:
 ;  procedure requested needs Rad/NM physician approval (File 71, fld 11)
 ;  there are other outstanding orders for this procedure for this pt
 ;  user is inactivated (file 200, "I" node)
ORDPRC I $D(^RAMIS(71,+X,0)),$P(^(0),"^",11)["y" D CHKUSR I 'RAMSG W !!,"Please contact appropriate Imaging Service to request this procedure!  " K X,RAMSG Q
 S RAS3=+$P(^RAO(75.1,DA,0),"^")
ORDPRC1 Q:'$D(^RAO(75.1,"AP",RAS3,X))  S RAS4=X,RASCNT=0 K RAX
 F RAS5=0:0 S RAS5=$O(^RAO(75.1,"AP",RAS3,RAS4,RAS5)) Q:'RAS5  F RAS6=0:0 S RAS6=$O(^RAO(75.1,"AP",RAS3,RAS4,RAS5,RAS6)) Q:'RAS6  I $D(^RAO(75.1,RAS6,0)) S RAT=+$P(^(0),"^",5) I RAT>2 S RASCNT=RASCNT+1 D:$S('$D(RAQUIT):1,1:RASCNT>1) ORDMES
 I $D(RAX),'$D(RAQUIT) D ORDMES1
 K:$D(RAX) RAQUIT K RAMSG,RAS3,RAS4,RAS5,RAS6,RASCNT,RAT,RAX Q
 ;
CHKUSR ; Check if valid user
 N RAINADT,RAC
 S RAINADT=+$P($G(^VA(200,+$G(DUZ),"PS")),"^",4)
 S RAC=$O(^VA(200,+$G(DUZ),"RAC",0))
 S RAMSG=$S('($D(DUZ)#2):0,'$D(^VA(200,DUZ,0)):0,'RAC:0,'RAINADT:1,'$D(DT):0,DT'>RAINADT:1,1:0)
 Q
ORDMES W:'$D(RAX) !!,*7,"The following requests are already on file for this procedure:",!
 W !?3,"A request dated " S Y=9999999.9999-RAS5 D DT^DIO2 W " is already ",$S(RAT=3:"on ",1:""),$P($P(^DD(75.1,5,0),RAT_":",2),";")," for this procedure." S RAX=1 Q
ORDMES1 W !!?3,"Is it ok to continue? No// " R RAX:DTIME S:'$T!(RAX="")!(RAX["^") RAX="N"
 I "Nn"[$E(RAX) K X S RAPRI=0
 I $D(X),"Yy"'[$E(RAX) W !!?3,"Enter 'YES' to request this procedure for this patient, or 'NO' not to.",! G ORDMES1
 Q
 ;
 ;Called (from RAPSET) to determine if at least one division and at
 ;least one location are set up.  Can't use pkg unless these are set up.
CHKSP S RADV=$S($O(^RA(79,0))>0:1,1:0),RALC=$S($D(^RA(79.1,+$O(^RA(79,"AL",0)),0)):1,1:0)
 Q
 ;
KILLVAR ;This call will clean up possible variables left after execution
 ;of the Label print fields in file 78.7
 K RAY0,RAY1,RAY2,RAY3,RAGE,RACSE,RANOW,RADOB,RAEXDT,RATRAN,RARPDT,RADIAG,RAMOD,RAINST,RAEXLST,RAVST,RALCSE,RANM,RAPAGE,RAPR,RAL,RARST,RAREA,RADOC,RARAD,RASSN
 K RASTAFF,RASIGS,RATECH,RACTY,RASIGVES,RAVER,RASIGVS,RASIGVSB,RASIGR,RASERV,RASEX,RAS,RAII,RAFMT,RASV
 Q
 ;
CONTRAST(RAZ71) ;Display the contrast media/medium associated with a Rad/Nuc
 ;Med Procedure. Called from: PRC1^RAUTL8 & ALLERGY^RAORD1
 ;input: RAZ71=ien of the non-parent procedure in file 71
 ;
 K RAZCM S RAZ71(0)=$G(^RAMIS(71,RAZ71,0))
 S RAZCMU=$P(RAZ71(0),"^",20) ;is contrast media used?
 I RAZCMU'="Y" K RAZCMU Q
 D GETS^DIQ(71,RAZ71_",","125*","E","RAZCM")
 ; The RAZCM(71.0125,x,.01,"E") array will be one or more of following
 ; values: I:Iodinated contrast, ionic;N:Iodinated contrast, non-ionic
 ;         L:Gadolinium, C:Cholecystogram;G:Gastrografin;B:Barium
 ;
 S:$O(RAZCM(71.0125,$C(126)),-1)=$O(RAZCM(71.0125,"")) RAZTAG="medium"
 S:'$D(RAZTAG)#2 RAZTAG="media"
 S RAPMSG(1)="**************   Patient reaction to contrast "_RAZTAG_"   *************"
 S RAPMSG(2)=$E($P(RAZ71(0),"^"),1,47)_" uses contrast "_RAZTAG_": "
 S RAPMSG(2,"F")="!",RAZI="",RAZSUB=$O(RAPMSG($C(32)),-1)
 F  S RAZI=$O(RAZCM(71.0125,RAZI)) Q:RAZI=""  D
 .S:$L($G(RAPMSG(RAZSUB)))+$L(RAZCM(71.0125,RAZI,.01,"E"))>69 RAZSUB=RAZSUB+1
 .S RAPMSG(RAZSUB)=$G(RAPMSG(RAZSUB))_RAZCM(71.0125,RAZI,.01,"E")_", "
 .Q
 ; The reverse dollar order (R$O) is used to strip off the ", " string
 ; from the last printable subscript containing CM data. I also use the
 ; R$O to set my last printable array element to '*'s to box off the
 ; warning.
 S RAPMSG($O(RAPMSG($C(32)),-1))=$E(RAPMSG($O(RAPMSG($C(32)),-1)),1,$L(RAPMSG($O(RAPMSG($C(32)),-1)))-2) ;strips off the ", "
 S $P(RAPMSG($O(RAPMSG($C(32)),-1)+1),"*",69)="",RAPMSG(99)=" "
 D EN^DDIOL(.RAPMSG)
 K RAPMSG,RAZCM,RAZCMU,RAZI,RAZTAG,RAZSUB
 Q
 ;
DELCM(DA) ;Ask the user if he/she is sure that deletion of contrast media
 ;is intended. If the user enter '^' exit editng the template
 ; input: DA=the ien of the record in file 71
 ;output: RAYN=response to 'Are you sure?'; either 'Y', 'N', or '^'  
 ;Called from the RA PROCEDURE EDIT input template (RA*5*45)
 N RAYN W !?3,"*** Deleting all contrast media data associated with this procedure. ***"
 F  D  Q:$L($G(RAYN))
 .R !!?3,"All contrast relationships with this procedure will be deleted.",!?3,"Are you sure you want to delete? N// ",RAYN:DTIME
 .S:'$T!(RAYN["^") RAYN="^" Q:RAYN="^"
 .S:RAYN="" RAYN="N" Q:RAYN="N"
 .S RAYN=$$UP^XLFSTR($E(RAYN)) Q:RAYN="Y"!(RAYN="N")
 .I RAYN["?" W !?3,"Enter 'Y'es to delete associated contrasts, or 'N'o to preserve associated",!?3,"contrasts." K RAYN Q
 .K RAYN W !?3,"Please enter 'Y' for yes, or 'N' for no."
 .Q
 ;The user does not want to delete associated cm data or has '^' out of
 ;the option. We must reset the CONTRAST MEDIA USED (#20) field back to
 ;yes from no.
 I RAYN'="Y" D
 .K RAFDA S RAFDA(71,DA_",",20)="Y" D FILE^DIE("","RAFDA")
 .K RAFDA Q
 Q RAYN
 ;
