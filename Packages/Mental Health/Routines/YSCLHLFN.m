YSCLHLFN ;DSS-PO/HEC-hrubovcak - Testing support - CLOZAPINE DATA TRANSMISSION ;19 May 2020 14:13:48
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 Q
 ;
 ; Reference to ^DIC supported by DBIA #2051
 ; Reference to ^XLFDT supported by DBIA #10103
 ;
TSEND ; SEND HL7 message - Entry point for development /testing
 N DFN,HLRSLT,J,PSGORD,PSORXIEN
 W !,"Send the HL7 message(s) to Healthshare for selected patient.",!
 D ASKUSER(.DFN,.PSGORD,.PSORXIEN)
 I 'DFN W !,"No Patient defined"  Q
 ;
 S X=$$NOW^XLFDT W !!,"Current Time: ",$$FMTE^XLFDT(X,"2S")," (",X,")"
 W !,"DFN = ",DFN,"   PSOGORD = ",PSGORD," PSORXIEN = ",PSORXIEN,!
 D SENDHL7(DFN,PSGORD,PSORXIEN,.HLRSLT)
 I '$O(HLRSLT(0)) W !,"Nothing sent."
 S J=0 F  S J=$O(HLRSLT(J)) Q:'J  W !,"HLO message info: "_HLRSLT(J)
 Q
 ;
TGET ; Display YSCLARR values  - Entry point for development /testing
 N DFN,PSGORD,PSORXIEN,V K YSCLARR
 W !,"Get the YSCLARR  values for a given patient. It is safe to run anytime."
 W !,"No HL7 message will be sent.",!
 D ASKUSER(.DFN,.PSGORD,.PSORXIEN)
 I 'DFN W !,"No Patient defined" Q
 ;
 D GET^YSCLHLGT(.YSCLARR,DFN,PSGORD,PSORXIEN)
 S V="YSCLARR" F  S V=$Q(@V)  Q:V=""  W !,V_$C(61,34)_@V_$C(34)
 Q
 ;
TSAVE ; SAVE message data - Entry point for development / testing
 N DFN,PSGORD,PSORXIEN
 W !,"Save the YSCLARR in "_$NA(^XTMP("YSCLHL7"))_" global for later HL7 Message transfer to HS",!
 D ASKUSER(.DFN,.PSGORD,.PSORXIEN)
 I 'DFN W !,"No Patient defined"  Q
 ; not used
 ;D SAVEDATA^YSCLHLMA(DFN,PSGORD,PSORXIEN)
 Q
 ;
SENDHL7(DFN,PSGORD,PSORXIEN,HLRSLT) ; Build and send registration and clinical/dispense messages 
 ; input:   DFN        patient file IEN
 ;          PSGORD     parmacy patient file UnitDose ien  e.g. 167 or 167U
 ;          PSORXIEN   prescription ien  of prescription file
 K HLRSLT  ; passed by ref.
 K YSCLARR  ; in symbol table
 N I,NODE,YSUDSIEN
 I $G(PSGORD)>0 D
 . S YSUDSIEN=+$G(PSGORD("UNDSIEN"))
 . D GETCLZOR^YSCLHLGT(.YSCLARR,DFN,YSUDSIEN)
 . D GET^YSCLHLGT(.YSCLARR,DFN,PSGORD,0)
 . D XMI1PT^YSCLHLMA(.YSCLARR,.HLRSLT)
 ;
 ;
 I $G(PSORXIEN) D
 . D GET^YSCLHLGT(.YSCLARR,DFN,0,PSORXIEN)
 . D XMI1PT^YSCLHLMA(.YSCLARR,.HLRSLT)
 ;
 Q
 ;
ASKUSER(DFN,PSGORD,PSORXIEN) ; ask user for input, all vars. passed by ref.
 ;
 ; Select patient from CLOZAPINE PATIENT LIST 
 N D,DIC,X,Y,YSCLP,YSCLR,DUOUT
 ;
 S DFN=0,PSGORD=0,PSORXIEN=0,DIC=603.01,DIC(0)="AEMQZ"
 S DIC("W")="N YS0 S YS0=^(0) W "" "",$P(^DPT($P(YS0,U,2),0),U),"" (#"",$P(YS0,U,2),"")"""
 D ^DIC
 I $G(DUOUT) S DFN=0 W !,"Aborted...." Q
 S DFN=+$P($G(Y(0)),U,2)
 Q:'(DFN>0)
 ;
 K DIC S DIC="^PS(55,"_DFN_",5," S DIC(0)="AEMQZ" D ^DIC
 I $G(DUOUT) S DFN=0 W !,"Aborted...."  Q
 S PSGORD=$S($P($G(Y),U)>0:$P($G(Y),U),1:0)
 I PSGORD S PSGORD("UNDSIEN")=+Y
 ;
 I PSGORD=0 D
 . K DIC S DIC="^PS(55,"_DFN_",""P""," S DIC(0)="AEQZ"
 . S DIC("W")="N YS0,YSDRG S YS0=^(0),YSDRG=$P($G(^PSDRUG(+$P($G(^PSRX(+YS0,0)),U,6),0)),U) W "" - ""_YSDRG"
 . D ^DIC
 . I $G(DUOUT) S DFN=0 W !,"Aborted...."  Q
 . S PSORXIEN=$S($G(Y(0))>0:$G(Y(0)),1:0)
