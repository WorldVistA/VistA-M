GMRCTIUP ;SLC/DCM,JFR - TIU/Consults UTILITIES; 4/4/01 15:01
 ;;3.0;CONSULT/REQUEST TRACKING;**4,13,15,17,22**;DEC 27, 1997
 ;
 ; This routine invokes IA #616,#2693
 ;
HDR(GMRCTUPR,GMRCGLB,COUNT,FROM) ;Get Source info for header of display
 ;and place data in ^TMP( global. Do Not Show Any Results
 ;GMRCTUPR=TIU record being sought
 ;GMRCGLOB=Global where data goes - i.e., ^TMP("GMRCR",$J,"RES",GMRCPTR,"ADD",GMRCADD,LINECT,0)
 ;COUNT=Count of where current line is to go in ^TMP( global
 ;FROM=flag to tell whether to add Addendum TIU # or not 0=NO, Otherwise addendum number
 N DR,GMRCTMP
 S:'$D(FROM) FROM=""
 S DR=".01;.05;.07;.09;1201;1202;1204;1205;1208;1301;1302",GMRCERR=""
 D EXTRACT^TIULQ(GMRCPTR,"LOCAL",.GMRCERR,DR)
 S @GMRCGLB@(COUNT,0)="",COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="Source Information",COUNT=COUNT+1,@GMRCGLB@(COUNT,0)=""
 S @GMRCGLB@(COUNT,0)="  Document Status: "_LOCAL(GMRCPTR,.05,"E"),COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="       Entry Date: "_$P($G(LOCAL(GMRCPTR,1201,"E")),":",1,2),COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="            Visit: "_$G(LOCAL(GMRCPTR,.07,"E"))_"  "_$G(LOCAL(GMRCPTR,1205,"E"))
 S COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="           Author: "_LOCAL(GMRCPTR,1202,"E")
 S COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="  Expected Signer: "_$E(LOCAL(GMRCPTR,1204,"E")_TAB,1,22)_$E(TAB,1,5)_"Expected Cosigner: "_$S($L($G(LOCAL(GMRCPTR,1208,"E"))):LOCAL(GMRCPTR,1208,"E"),1:"None"),COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="       Entered By: "_$E(LOCAL(GMRCPTR,1302,"E")_TAB,1,30)_"TIU Document #: "_GMRCTUPR,COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)=$S(+FROM:"  TIU Addendum Document #: "_FROM,1:"")_$S(+FROM:$E(TAB,1,10),1:"     ")_"     Urgency: "_$S($L($G(LOCAL(GMRCPTR,.09,"E"))):LOCAL(GMRCPTR,.09,"E"),1:"None"),COUNT=COUNT+1
 S @GMRCGLB@(COUNT,0)="",COUNT=COUNT+1
 K LOCAL
 Q
PRINT(GMRCO,LINECT,GMRCRT,GMRCDET) ;get TIU results and prepare for the SF-513
 ;GMRCRT=Flag from RT^GMRCA1 indicating that result request is from there
 ; GMRCRT=0 means 'NO', 
 ; GMRCRT=1 means 'YES" (and ES is appended to TIU main result); also, 
 ;    No result is passed back to print on the 513 if GMRCRT=0.
 ;GMRCTUFN=IEN of the TIU result from file 8925
 ;GMRCSIG=signature block name of signer : GMRCSDT=date result was signed
 ;GMRCSIGT=signers block title : GMRCTUFN=TIU IEN of the result record
 ;GMRCCSIG=cosigners block name : GMRCCSDT=date cosigner signed
 ;GMRCCTIT=cosigners block title : GMRCSIGM=Signature mode (E:ELECTRONIC/C:CHART)
 ;I GMRCDET=1 coming from a detailed display not results display
 N GMRCTUFN,TAB,GLOBAL
 S:'$D(GMRCRT) GMRCRT=0 S:'$D(GMRCDET) GMRCDET=0
 D GETRSLTS(GMRCO,.GMRCAR) ;I $D(GMRCQUT) D:$D(GMRCMSG) EXAC^GMRCADC(GMRCMSG) K GMRCMSG,GMRCRT Q
 S GLOBAL="^TMP(""GMRCR"",$J,""GMRCTIU"")",TAB="",$P(TAB," ",31)=""
 K ^TMP("GMRCR",$J,"RES"),^TMP("GMRCR",$J,"MCAR")
 S (GMRCND,GMRCPTR)="" F  K @GLOBAL S GMRCND=$O(GMRCAR(GMRCND)) Q:GMRCND=""  S GMRCPKG=$P(GMRCND,";",2),GMRCPTR=$P(GMRCND,";",1) D
 .I $E(GMRCPKG,1,3)="TIU" D
 .. N GMRCTXT,GMRCPAR,GMRCACTN
 .. D EXTRACT^TIULQ(GMRCPTR,"GMRCPAR",.GMRCERR,.06,"I")
 .. I $D(GMRCAR(+$G(GMRCPAR(GMRCPTR,.06,"I"))_";TIU(8925,")) Q
 .. S GMRCACTN=$S($G(GMRCRT):"VIEW",1:"PRINT RECORD")
 .. D TGET^TIUSRVR1(.GMRCTXT,+GMRCPTR,GMRCACTN)
 .. I $D(@(GMRCTXT)) M @GLOBAL@(GMRCPTR,"TEXT")=@GMRCTXT
 .. K @GMRCTXT
 .. I $O(@GLOBAL@(GMRCPTR,"TEXT",0)) D
 ...S ND=0 F  S ND=$O(@GLOBAL@(GMRCPTR,"TEXT",ND)) Q:ND=""  D
 ....S ^TMP("GMRCR",$J,"RES",GMRCPTR,"TEXT",LINECT,0)=@GLOBAL@(GMRCPTR,"TEXT",ND)
 ....S LINECT=LINECT+1
 ..Q
 .I $E(GMRCPKG,1,4)="MCAR" S GMRCSR=GMRCND,MCFILE=$P(GMRCSR,";",2),MCFILE=$P(MCFILE,","),MCPROC=$O(^MCAR(697.2,"C",MCFILE,"")) Q:'MCPROC  D
 ..S GMRCPRNM=$P(^MCAR(697.2,MCPROC,0),"^",8),ORIFN=$P(^GMR(123,GMRCO,0),"^",3),ORACTION=8,MCGLOBAL="^TMP(""GMRCR"",$J,""MCAR"","_GMRCPTR_")"
 ..D EN^GMRCTIU3(GMRCO,ORIFN,MCGLOBAL,LINECT) K ^TMP("MC",$J)
 ..Q
 .Q
 ; inter-facility remote results
 I 'GMRCDET,$O(^GMR(123,GMRCO,51,0)) D
 .N GMRCTMP S GMRCTMP="^TMP(""GMRCR"",$J,""RRES"")" K @GMRCTMP
 .S GLOBAL="^TMP(""GMRCR"",$J,""GMRCRRES"")" K @GLOBAL
 .D GETREMOT^GMRCART(GMRCO,GMRCTMP,LINECT)
 .I $D(@(GMRCTMP)) M @GLOBAL@(.5,"TEXT")=@GMRCTMP K @GMRCTMP
 .I $O(@GLOBAL@(.5,"TEXT",0)) D
 ..S ND=0 F  S ND=$O(@GLOBAL@(.5,"TEXT",ND)) Q:ND=""  D
 ...S ^TMP("GMRCR",$J,"RES",.5,"TEXT",LINECT,0)=@GLOBAL@(.5,"TEXT",ND,0)
 ...S LINECT=LINECT+1
 .Q
 K DR,GLOBAL,GMRCSR,GMRCAR,GMRCPKG,GMRCPRNM,MCFILE,MCPROC,ORACTION,ORIFN,MCGLOBAL,ND,ND1,GMRCND,GMRCPTR
 Q
GETNOTE(GMRCO,FILE) ;Get the last result added to the record - this is found in $P(^(0),"^",20)
 ;Function returns last note added to record.
 ;If it does not contain the file pointer, it is assumed that
 ;it pointed to the TIU file 8925
 ;GMRCO=file 123 IEN
 ;FILE='MCAR' to get last medicine result pointer
 ;FILE='TIU' to get last TIU result pointer
 N X,RSLT
 S RSLT=999999,X=""
 F  S RSLT=$O(^GMR(123,+GMRCO,50,RSLT),-1) Q:'RSLT  D  Q:+X
 . I $G(^GMR(123,+GMRCO,50,RSLT,0))[FILE S X=^GMR(123,+GMRCO,50,RSLT,0)
 Q X
GETRSLTS(GMRCO,ARRAY) ;Get the results from record and return it in array 'ARRAY')
 ;Looks for results in $P(^(0),"^",20),$P(^(0),"^",15) and Field 50 multiple
 ;GMRCO=File 123 IEN
 ;ARRAY=array to return results pointers in
 ;ARRAY will be returned as ARRAY("IEN;FILE"), as e.g., "1289;^TIU(8925,"
 N X
 S X=$$GETNOTE(GMRCO,"TIU") I $L(X) S:$P(X,";",2)="" X=X_";TIU(8925," S ARRAY(X)=""
 S X=$$GETNOTE(GMRCO,"MCAR") I $L(X) S ARRAY(X)=""
 S X="" F  S X=$O(^GMR(123,GMRCO,50,"B",X)) Q:X?1A.E!(X="")  S ARRAY(X)=""
