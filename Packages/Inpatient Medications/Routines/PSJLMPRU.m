PSJLMPRU ;BIR/MLM-INPATIENT LISTMAN UD PROFILE UTILITIES ;27 Aug 98 / 8:45 AM
 ;;5.0;INPATIENT MEDICATIONS;**16,58,85,110,185,181,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
PUD(DFN,ON,PSJF,DN) ; Setup LM profile view for UD
 N PSJFLAG,PSJV
 ; Naked references on the two lines below refer to full reference ^PS(55,DFN,5,+ON in PSJF using indirection.
 S ND=$G(@(PSJF_+ON_",0)")),SCH=$G(^(2)),ND4=$G(^(4)),ND6=$G(^(6)),NDP2=$G(^(.2)),PSJFLAG=$P(NDP2,U,7),X=$P(DN,U,2),DO=$S('X:"",1:$G(^(+X))) S:X=.2 DO=$P(DO,U,2)
 S ND14=$G(@(PSJF_+ON_",14,0)")),RNDT="" I $P(ND14,"^",3) S ND14=$G(^($P(ND14,"^",3),0)),RNDT=$P(ND14,"^")
 I ("AO"[PSJC)!(PSJC="DF") D
 .S V='$P(ND4,"^",UDU),PSJL=$$SETSTR^VALM1($S(ND4="":" ",$P(ND4,"^",12):"D",$P(ND4,"^",19)&$P(ND4,"^",18):"H",$P(ND4,"^",23)&$P(ND4,"^",22):"H",$P(ND4,"^",15)&($P(ND4,"^",16)!V):"R",1:" "),PSJL,5,1)
 .;S X=$S(+PSJSYSU=1&V:1,+PSJSYSU=3&V:1,1:0)
 .S PSJV=$S($P(NDP2,U,4)="D":"d",1:" ")_$S(+PSJSYSU=1&V:"->",+PSJSYSU=3&V:"->",1:"   ") I PSJFLAG D CNTRL^VALM10(PSJLN,1,4,IORVON,IORVOFF,0)
 .S PSJL=$$SETSTR^VALM1(PSJV,PSJL,6,3)
 S RTE=$P(ND,"^",3),SM=$S('$P(ND,"^",5):0,$P(ND,"^",6):1,1:2),STAT=$S($P(ND,U,28)]"":$P(ND,U,28),$P(ND,"^",9)]"":$P(ND,"^",9),1:"NF"),PF=$E("*",$P(ND,"^",20)>0),PSGID=$P(SCH,"^",2),SD=$P(SCH,"^",4),SCH=$P(SCH,"^")
 I STAT="A",$P(ND,U,27)="R" S STAT="R"
 S NF="",WS=$S(PSJPWD:$$WS^PSJO(PSJPWD,PSGP,PSJF,+ON),1:0)
 N PSJDISP F PSJDISP=0:0 S PSJDISP=$O(@(PSJF_+ON_",1,"_PSJDISP_")")) Q:'PSJDISP  D
 .I $P($G(^PSDRUG(+$P($G(@(PSJF_+ON_",1,"_PSJDISP_",0)")),"^"),0)),"^",9)=1 S NF=1
 NEW DRUGNAME,PSGID1,SD1,LEN,PSGID1,SD1 S LEN=$S($D(PSJEXPT):8,1:5)
 F X="PSGID","SD" S @(X_1)=$S(PSJC["C":"*****",1:$E($$ENDTC^PSGMI(@X),1,LEN))
 D DRGDISP^PSJLMUT1(PSGP,ON,39,54,.DRUGNAME,0)
 F PSJX=0:0 S PSJX=$O(DRUGNAME(PSJX)) Q:'PSJX  D
 .I PSJX=1 D
 ..I PSJFLAG D CNTRL^VALM10(PSJLN,1,4,IORVON,IORVOFF,0)
 ..S PSJL=$$SETSTR^VALM1($S($E(PSJS)="*":$P(PSJS,"^"),1:DRUGNAME(PSJX)),PSJL,9,39)
 ..S PSJL=$$SETSTR^VALM1($S(PSJC["C":"?",PSJSCHT'="z":PSJSCHT,1:"?"),PSJL,50,3)
 ..S PSJL=PSJL_PSGID1_"  "_SD1_" "_$E(STAT,1,2)_$S($L(STAT)=1:"     ",1:"    ")_$S($G(RNDT):$E($$ENDTC^PSGMI(RNDT),1,LEN),1:"")
 ..I NF!WS!SM!PF S PSJL=$$SETSTR^VALM1($S(NF:"NF ",WS:"WS ",SM:$E("HSM",SM,3),1:""),PSJL,69,3) S:PF PSJL=$$SETSTR^VALM1("*",PSJL,79,1)
 . I PSJX>1 S PSJL="",PSJL=$$SETSTR^VALM1(DRUGNAME(PSJX),PSJL,11,66)
 . D SETTMP("PSJPRO",PSJL) I ($P(NDP2,U,4)="S"),STAT="P" D CNTRL^VALM10((PSJLN-1),9,9+$L(PSJL),IOINHI_IOBON,IOINORM,0)
 I ND6'="" N X,PSJTXT3 S X=$$GETSIOPI^PSJBCMA5(DFN,ON) N TXTLN S TXTLN=0 F  S TXTLN=$O(^PS(53.45,DUZ,5,TXTLN)) Q:'TXTLN!$G(PSJTXT3)  D
 .I ($O(^PS(53.45,DUZ,5," "),-1)>3) S PSJTXT3=1 S PSJL="Instructions too long. See Order View for full text." D PTXT(PSJL,"PSJPRO",10,66) Q
 .S PSJL=^PS(53.45,DUZ,5,TXTLN,0) D PTXT(PSJL,"PSJPRO",10,66)
 K ^PS(53.45,DUZ,5)
 Q
 ;
PTXT(TXT,SUB,LM,RM) ; Display Instructions/dosage ordered.
 ;* Input:       TXT = Text to display.
 ;                       SUB = First subscript for ^TMP node, ** MUST be PSJ namespace **
 ;                       LM  = Begin display of text after LM spaces.
 ;                       RM  = Length of display text.
 ;                       
 ;BHW;PSJ*5*185;Extra spaces causes display to "skip" part of the field. 
 ;S PSJL="",$P(PSJL," ",LM)="" F X=1:1 S WRD=$P(TXT," ",X) Q:WRD=""  D
 S PSJL="",$P(PSJL," ",LM)=""
 F X=1:1:$L(TXT," ") S WRD=$P(TXT," ",X) D
 .;BHW;PSJ*5*185;check if end of string or just extra space
 .I WRD="" S PSJL=PSJL_" " Q 
 .I $L(PSJL_" "_WRD)'<RM D SETTMP(SUB,PSJL) S PSJL="",$P(PSJL," ",10)=""
 .I $L(PSJL_" "_WRD)'<RM S PSJL=PSJL_" "_$E(WRD,1,(RM-10)) D SETTMP(SUB,PSJL) S PSJL="",$P(PSJL," ",10)="",WRD=$E(WRD,(RM-9),$L(WRD))
 .S PSJL=PSJL_" "_WRD
 D SETTMP(SUB,PSJL)
 Q
SETTMP(SUB,PSJL) ;
 S ^TMP(SUB,$J,PSJLN,0)=PSJL,PSJLN=PSJLN+1
 Q
