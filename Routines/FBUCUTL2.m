FBUCUTL2 ;ALBISC/TET - UTILITY (CONTINUED) ;2/12/2003
 ;;3.5;FEE BASIS;**23,32,38,52**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDRESS(FBUCA) ;set up address (FBADD) and carbon copy address (FBADDCC)
 ;INPUT:  FBUCA = current (or after) zero node for UC (file #162.7)
 ;OUTPUT: FBADD( array, subscripted by sequential number; FBADD = count
 ;        FBADDCC( array, subscripted by sequential number; FBADDCC=count
 N FBDA,FBGL,FBSUB
 K FBADD,FBADDCC
 S FBSUB=$P(FBUCA,U,23)
 S:FBSUB']"" FBSUB=$P(FBUCA,U,4)_";DPT("
 S FBDA=+$P(FBSUB,";")
 I FBSUB["FBAAV" D VENADD(FBDA,.FBADD) D VETADD($P(FBUCA,U,4),.FBADDCC)
 I FBSUB["DPT" D VETADD(FBDA,.FBADD) D VENADD($P(FBUCA,U,3),.FBADDCC)
 I FBSUB["VA(200" D OTHADD(FBDA,.FBADD) D VETADD($P(FBUCA,U,4),.FBADDCC)
 Q
VETADD(DFN,FBARR) ;set up veteran address
 ;INPUT:  DFN = veteran ien
 ;        FBARR array that will hold the address (passed by reference)
 ;VAPA("CD") - date for ADD^VADPT if not defined then NOW will be used 
 ;    VAPA will be killed!     
 ;
 ;OUTPUT  FBARR array will contain the veteran mailing address,
 ;              subscripted by sequential number; FBARR = line count
 N FBCT,FBI
 K FBARR
 S FBCT=0
 I $G(DFN)>0 D
 .S FBCT=FBCT+1,FBARR(FBCT)=$$GETNAME^FBUCLET1(DFN,2,"G")
 .D ADD^VADPT I 'VAERR D  K VAPA,VAERR
 . . I $$ACTIVECC^FBAACO0() D  Q
 . . . F FBI=13,14,15 S:$G(VAPA(FBI))]"" FBCT=FBCT+1,FBARR(FBCT)=$G(VAPA(FBI))
 . . . S FBCT=FBCT+1,FBARR(FBCT)=$S($G(VAPA(16))]"":$G(VAPA(16)),1:"     ")_"  "_$S($P($G(VAPA(17)),U,2)]"":$P($G(VAPA(17)),U,2),1:"  ")_"  "_$P($G(VAPA(18)),U,2)
 ..F FBI=1,2,3 S:VAPA(FBI)]"" FBCT=FBCT+1,FBARR(FBCT)=VAPA(FBI)
 ..S FBCT=FBCT+1,FBARR(FBCT)=$S(VAPA(4)]"":VAPA(4),1:"     ")_"  "_$S($P(VAPA(5),U,2)]"":$P(VAPA(5),U,2),1:"  ")_"  "_$S('+$G(VAPA(11)):VAPA(6),$P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:VAPA(6))
 S FBARR=FBCT
 Q
 ;
VENADD(FBV,FBARR) ;set up vendor address
 ;INPUT:  FBV = vendor ien (file 161.2)
 ;        FBARR array that will hold the address (passed by reference)
 ;OUTPUT  FBARR array will contain the vendor mailing address,
 ;              subscripted by sequential number; FBARR = line count
 N FBCT,FBP,FBSTATE,FBZ
 K FBARR
 S FBCT=0
 I $G(FBV)>0 D
 .S FBZ=$G(^FBAAV(FBV,0))
 .S FBCT=FBCT+1,FBARR(FBCT)=$P(FBZ,U)
 .I FBARR(1)["," S FBARR(1)=$P(FBARR(1),",",2)_" "_$P(FBARR(1),",")
 .S FBSTATE=$P($G(^DIC(5,+$P(FBZ,U,5),0)),U,2)
 .F FBP=3,14 S:$P(FBZ,U,FBP)]"" FBCT=FBCT+1,FBARR(FBCT)=$P(FBZ,U,FBP)
 .S FBCT=FBCT+1,FBARR(FBCT)=$S($P(FBZ,U,4)]"":$P(FBZ,U,4),1:"     ")_"  "_$S(FBSTATE]"":FBSTATE,1:"  ")_"  "_$P(FBZ,U,6)
 S FBARR=FBCT
 Q
OTHADD(FBDA,FBARR) ;set up other party address
 ;INPUT:  FBDA = other party ien (file 200)
 ;        FBARR array that will hold the address (passed by reference)
 ;OUTPUT  FBARR array will contain the vendor mailing address,
 ;              subscripted by sequential number; FBARR = line count
 N FBCT,FBP,FBSTATE,FBZ11
 K FBARR
 S FBCT=0
 I $G(FBDA)>0 D
 .S FBCT=FBCT+1,FBARR(FBCT)=$$GETNAME^FBUCLET1(FBDA,200,"G")
 .S FBZ11=$G(^VA(200,FBDA,.11))
 .I FBZ11]"" D
 ..S FBSTATE=$P($G(^DIC(5,+$P(FBZ11,U,5),0)),U,2)
 ..F FBP=1,2,3 S:$P(FBZ11,U,FBP)]"" FBCT=FBCT+1,FBARR(FBCT)=$P(FBZ11,U,FBP)
 ..S FBCT=FBCT+1,FBARR(FBCT)=$S($P(FBZ11,U,4)]"":$P(FBZ11,U,4),1:"     ")_"  "_$S(FBSTATE]"":FBSTATE,1:"  ")_"  "_$P(FBZ11,U,6)
 S FBARR=FBCT
 Q
STATADD ;station address, from fee basis site parameter file
 ;INPUT:  nothing
 ;OUTPUT: FBSADD( array of station name,address, and number
 ;called when printing a letter, used if letterhead not used
 K ^UTILITY("DIQ1",$J) N DIC,DA,DIQ,DR,FBCT,FBP S DIC="^FBAA(161.4,",DA=1,DIQ="FBSADD(" D
 .S DR="1:2;16",DIQ(0)="EN" D EN^DIQ1
 .S DR="3:5;35.6",DIQ(0)="E" D EN^DIQ1
 .;S DR=27,DIQ(0)="IN" D EN^DIQ1
 I $G(FBSADD(161.4,1,16,"E"))]"" S FBSADD(161.4,1,2.5,"E")=FBSADD(161.4,1,16,"E") K FBSADD(161.4,1,16,"E") ;set street address lines together
 S FBSADD(161.4,1,.01,"E")=$G(FBSADD(161.4,1,35.6,"E")) K FBSADD(161.4,1,35.6,"E") ;re-set so name is first
 S (FBCT,FBP)=0 F  S FBP=$O(FBSADD(161.4,1,FBP)) Q:FBP'<3!('FBP)  S:$G(FBSADD(161.4,1,FBP,"E"))]"" FBCT=FBCT+1,FBSADD(FBCT)=FBSADD(161.4,1,FBP,"E") K FBSADD(161.4,1,FBP)
 S FBCT=FBCT+1,FBSADD(FBCT)=$S($G(FBSADD(161.4,1,3,"E"))]"":FBSADD(161.4,1,3,"E"),1:"     ")_"  "_$S($G(FBSADD(161.4,1,4,"E"))]"":FBSADD(161.4,1,4,"E"),1:"  ")_"  "_$G(FBSADD(161.4,1,5,"E")) F FBP=3:1:5 K FBSADD(161.4,1,FBP)
 K ^UTILITY("DIQ1",$J) Q
STANUM ;get station number
 ;INPUT:  nothing
 ;OUTPUT: FBSTANUM = station number of PSA, as set in FB site parameter
 K ^UTILITY("DIQ1",$J) N DA,DIC,DIQ,DR S DA=1,DIC="^FBAA(161.4,",DIQ="FBSTA(",DR=27,DIQ(0)="IN" D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 S FBSTANUM=$G(FBSTA(161.4,1,27,"I")) I FBSTANUM]"" S FBSTANUM=$P($G(^DIC(4,FBSTANUM,99)),U)
 K FBSTA(161.4) Q
LETTER(FBORDER,FB1725) ;get letter ien number
 ;INPUT:  FBORDER = order number of status
 ;        FB1725 = (optional) =true to select a 38 U.S.C. 1725 letter
 ;OUTPUT:  ien of letter or 0
 N Y,PIECE
 S Y=+$O(^FB(162.92,"AO",FBORDER,0))
 S PIECE=$S($G(FB1725):6,1:5)
 Q +$P($G(^FB(162.92,Y,0)),"^",PIECE)
 ;
TXT(FBGL,FBIEN,FBN,DIWF,DIWL,FBLET,FBCC,FBCCI,FBLBL) ;write txt
 ;INPUT:  FBGL = global root
 ;        FBIEN = internal entry number of file
 ;        FBN = node where wp info resides
 ;        DIWF = format
 ;        DIWL = left offset
 ;        FBLET = 1 if coming from letter (optional)
 ;        FBCC = 1 if CC address will print at bottom of page (optional)
 ;               passed by reference
 ;        FBCCI = number lines needed for CC address (required if FBCC=1)
 ;        FBLBL = label text to print at beginning of 1st line (optional)
 N FBI,FBNODE,FBTXT,X S FBNODE=FBGL_FBIEN_","_FBN S FBLET=$S('$D(FBLET):0,1:+FBLET)
 I $D(@(FBNODE_")")) S X=$G(FBLBL) D:X]"" ^DIWP S FBI=0 F  S FBI=$O(@(FBNODE_","_FBI_")")) Q:'FBI  S FBTXT=^(FBI,0),X=FBTXT D
 .I $Y+$S($G(FBCCI)>7&$G(FBCC):FBCCI,1:7)>IOSL W:'FBLET @IOF D:FBLET PAGE^FBUCLET1
 .D ^DIWP
 I $Y+$S($G(FBCCI)>7&$G(FBCC):FBCCI,1:7)>IOSL W:'FBLET @IOF D:FBLET PAGE^FBUCLET1
 D:$D(FBTXT) ^DIWW
 K FBLET Q
PAGE ;write page
 W @IOF Q
PDATE(FBDT) ;output fcn of date, long form
 ;INPUT: FBDT = date for output
 ;OUTPUT: month day, year
 N FBPDT,Y S Y=FBDT D PDATE^FBAAUTL Q $G(FBPDT)
 ;
FBUC(X) ;unauthorized claim parameters
 ;INPUT:  X = ien of parameter
 ;OUTPUT: "UC" node in parameter file
 Q $G(^FBAA(161.4,X,"UC"))
 ;
DIE(DIE,DA,DR) ;update a field
 ;INPUT:  DIE = global root
 ;        DA = record to be updated
 ;        DR = field to be updated
 ;OUTPUT: update record in file
 I $S($G(DIE)']"":1,$G(DR)']"":1,'+$G(DA):1,1:0) Q
 N FBLOCK
 D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -@(DIE_DA_")") K FBLOCK
 Q
