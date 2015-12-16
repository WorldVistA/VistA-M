DGPTOLC2 ;ALB/AS/ADL,HIOFO/FT - SUMMARY BY ADM RPT, lists diagnoses,sur,pro (cont.) ;3/19/15 11:44am
 ;;5.3;Registration;**164,510,559,599,729,850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 27, 2003
 ;
 ; ICDXCODE APIs - #5699
 ; VA(200) global - #10060
 ; VADPT APIs - #10061
 ; XLFDT APIs - #10103
 ;
EN ;called from DGPTOLC1
 D LO^DGUTL,NOW^%DTC S DGPT=0,DGDT=$TR($$FMTE^XLFDT(DT,"5DF")," ","0")_"@",%=$P(%,".",2),DGDT=DGDT_$E(%,1,2)_":"_$E(%_"0000",3,4)
 F PTF=0:0 S PTF=$O(DGPTF(PTF)) Q:PTF'>0  S DGNAME=$P(DGPTF(PTF),"^"),DGADM=$P(DGPTF(PTF),"^",2),DGPTF(DGNAME,DGADM,PTF)="" K DGPTF(PTF) ;put names in alphabetical order
 F DGPTX=0:0 S DGPT=$O(DGPTF(DGPT)) Q:DGPT']""  F DGADM=0:0 S DGADM=$O(DGPTF(DGPT,DGADM)) Q:DGADM'>0  S DGPG=1,PTF=$O(DGPTF(DGPT,DGADM,0)),DFN=$S($D(^DGPT(PTF,0)):+^(0),1:"") I DFN]"" S DGPMIFN=$O(^DGPM("APTF",PTF,0)) D E,HD,D
 D Q2^DGPTOLC1
 Q
E ;
 D EFFDATE^DGPTIC10(PTF)
 S DGELIG=$S('$D(^DPT(DFN,.36)):"Unknown",$D(^DIC(8,+$P(^(.36),"^"),0)):$P(^(0),"^"),1:"Unknown")
 N DGFLDPTR,DGFLDERR
 S %=""
 D FIELD^DID(2,.3611,,"POINTER","DGFLDPTR","DGFLDERR")
 S:$D(DGFLDPTR("POINTER")) %=";"_DGFLDPTR("POINTER")
 S X=$S($D(^DPT(DFN,.361)):$P(^(.361),"^"),1:"")
 S DGSTAT=$S(X']"":"Unknown",1:$P($P(%,";"_X_":",2),";",1))
 S DG70=$S($D(^DGPT(PTF,70)):^(70),1:""),DGFEE=$S($P(^DGPT(PTF,0),"^",4):1,1:"") I DGFEE S X1=$S(+DG70:+DG70,1:DT),X2=DGADM D ^%DTC S DGLOS=$S(X:X,1:1),DGLV=0,D1=0
 I '+DG70 S DGPRO=$S($D(^DPT(DFN,.104)):+^(.104),1:""),DGPRO=$S($D(^VA(200,+DGPRO,0)):$P(^(0),"^"),1:"Unknown")
 I +DG70 S DGPRO=$S('$D(^DGPT(PTF,"M",1,"P")):"",1:$P(^("P"),"^",5)),DGPRO=$S($D(^VA(200,+DGPRO,0)):$P(^(0),"^"),1:"") I DGPRO']"" D DGPRO
 Q
CRT I IOST?1"C-".E R !?20,"Enter <RETURN> to continue",Y:DTIME
HD W @IOF,?21,"PATIENT SUMMARY by ADMISSION",!!?51,"Run Date: ",DGDT,!,DGPT,?32,"SSN: ",$P(^DPT(+^DGPT(PTF,0),0),"^",9),?51,"Admitted: " S X=DGADM D DT
 W !,"Elig: ",DGELIG,"  (",DGSTAT,")",?50,"Discharge: " S X=$P(DG70,"^") D DT W ! W:DGFEE "Fee Basis"
 I DGPMIFN>0 W "Total LOS: " D ^DGPMLOS S X=+$P(X,"^")-(+$P(X,"^",2))-(+$P(X,"^",4)) W $S(X>0:X,1:"1") W ?18,"* Provider: ",$E(DGPRO,1,19)
 W ?55,"PTF #: ",PTF,?72,"Pg: ",DGPG S DGPG=DGPG+1 W:DGPMIFN>0 !,"* indicates the most recent PROVIDER entered for this admission",!
 Q
D G S:'$D(^DGPT(PTF,"M","AC"))
 K DGMD F DGS=0:0 S DGS=$O(^DGPT(PTF,"M",DGS)) Q:DGS'>0  I $D(^(DGS,0)) S DGMD=+$P(^(0),"^",10) S:'DGMD DGMD=999999999 S:$D(DGMD(DGMD)) DGMD=DGMD+.01*DGS S DGMD(DGMD)=DGS ;put movements in date order
 F DGS=0:0 S DGS=$O(DGMD(DGS)) Q:DGS'>0  I $D(^DGPT(PTF,"M",DGMD(DGS),0)) D
 . S DGM=^(0),X=$P(DGM,"^",10),DGBS=+$P(DGM,"^",2) ;^(0) references global on line above
 . W !!,"Movement Date: " D DT W:DGMD(DGS)=1 ?40,"(Discharge 501)" W $$GETLABEL^DGPTIC10(EFFDATE,"D") D:DGFEE LOS D BS
 . K DG501
 . D PTFICD^DGPTFUT(501,PTF,DGMD(DGS),.DG501,1)  ;get all DX and POAs for this multiple
 . S DGLOOP=0
 . F  S DGLOOP=$O(DG501(DGLOOP)) Q:'DGLOOP  S DGDXPOA=$G(DG501(DGLOOP)) D C
 I DG70 D
 . S DGM=DG70 W !!,"Discharge Move: (701/2/3 Diagnoses)",$$GETLABEL^DGPTIC10(EFFDATE,"D"),!
 . K DG701
 . D PTFICD^DGPTFUT(701,PTF,,.DG701,1)  ;get all DX and POAs for this multiple
 . S DGLOOP=""
 . F  S DGLOOP=$O(DG701(DGLOOP)) Q:DGLOOP=""  S DGDXPOA=$G(DG701(DGLOOP)) D C
 K DG501,DG701,DGDXPOA,DGLOOP
S ; --
 S DGF="S" F DGS=0:0 S DGS=$O(^DGPT(PTF,"S",DGS)) Q:DGS'>0  S DGSUR=^(DGS,0),X=+DGSUR W !!,"Surgery Date: " D DT W $$GETLABEL^DGPTIC10(EFFDATE,"P") D
 . F DGC=8:1:27 D P1
 . S DGSUR=$G(^DGPT(PTF,"S",DGS,1))   ;*884* get node with new/additional procedure codes
 . F DGC=1:1:5 D:$P(DGSUR,U,DGC) P1   ;*884* process procedure codes
 K DGF I $D(^DGPT(PTF,"401P")) S DGSUR=^("401P") W:'$D(DGF) !!,"Procedure: (401P)",$$GETLABEL^DGPTIC10(EFFDATE,"P") F DGC=1:1:5 D P1
 F DGS=0:0 S DGS=$O(^DGPT(PTF,"P",DGS)) Q:DGS'>0  S DGSUR=^(DGS,0),X=+DGSUR W !!,"Procedure Date: " D DT W $$GETLABEL^DGPTIC10(EFFDATE,"P") D
 . F DGC=5:1:24 D P1
 . S DGSUR=$G(^DGPT(PTF,"P",DGS,1))  ;*884* get node with new/additional procedure codes
 . F DGC=1:1:5 D:$P(DGSUR,U,DGC) P1  ;*884* process procedure codes
 W:DGFEE !,"Total LOS: ",$S(DGLOS>0:DGLOS,1:"1") W ! D:IOST?1"C-".E CONT
 Q
 ;
C ; --Print Diagnosis and POA display
 Q:'+$P(DGDXPOA,U,1)
 S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DGDXPOA,U,1),EFFDATE) D  ;*884* get DX entry record info
 . I $Y>($S($D(IOSL):IOSL,1:66)-4) D CRT W !,"Diagnosis Codes, (cont.)",$$GETLABEL^DGPTIC10(EFFDATE,"D")
 . W:DGLOOP=0 ?4,"PRINCIPAL DIAGNOSIS: "
 . D WRITECOD^DGPTIC10("DIAG",+$P(DGDXPOA,U,1),EFFDATE,2,1,7)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")     ;piece 1 is DX ien, piece 10 is STATUS (multiple)
 . Q:$P(DGPTTMP,U,20)=1  ;icd9 code, so there is no POA to display
 . W " ["_$S($P(DGDXPOA,U,2)]"":$P(DGDXPOA,U,2),1:" ")_"]"  ;show POA value in brackets
 Q
 ;
P1 ; -- Print Procedure Code
 Q:'+$P(DGSUR,"^",DGC)
 S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+$P(DGSUR,U,DGC),EFFDATE) D  ;*884* get procedure record info
 . I $Y>($S($D(IOSL):IOSL,1:66)-4) D CRT W !,$S('$D(DGF):"Non-OR Procedures",DGF="S":"Surgery",1:"Non-OR Procedures") W " Codes, (cont.)"
 . D WRITECOD^DGPTIC10("PROC",+$P(DGSUR,"^",DGC),EFFDATE,2,1,7)
 . W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"") ;piece 1 is DX ien, piece 10 is STATUS (multiple)
 Q
 ;
DT Q:X']""  W $TR($$FMTE^XLFDT(X,"5DF")," ","0") S X=$P(X,".",2) I X]"" W "@"_$E(X,1,2)_":"_$E(X_"0000",3,4)
 Q
BS S DGBS=$S('DGBS:DGBS,$D(^DIC(42.4,+DGBS,0)):$P(^(0),"^",1),1:"") W !,"Losing Specialty: ",DGBS
 Q
LOS F %=3,4 S DGLV=$P(DGM,"^",%)+DGLV
 S DGLOS=DGLOS-DGLV
 Q
CONT F Y=1:1:($S($D(IOSL):IOSL,1:66)-$Y-2) W !
 R ?20,"Enter <RETURN> to continue",Y:DTIME
 Q
DGPRO S X=$O(^DGPM("APTF",PTF,0)),VAIP("E")=$S('$D(^DGPM(+X,0)):"",1:$P(^DGPM(X,0),"^",17))
 I VAIP("E") D IN5^VADPT S DGPRO=$S($P(VAIP(7),"^",2)]"":$P(VAIP(7),"^",2),1:"Unknown") K VAIP Q
 S DGPRO="Unknown" K VAIP
 Q
