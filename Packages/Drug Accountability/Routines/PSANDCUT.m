PSANDCUT ;BIRM/MFR - NDC Utility ;07/01/08
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**69,72**;10/24/97;Build 2
 ;References to ^PSSNDCUT supported by IA #4707
 ;
NDCEDT(DRG,NDC) ; Allows editing of the Rx NDC code
 ; Input: (o) DRG   - Drug IEN (#50)
 ;        (o) NDC   - Default NDC Number/Return parameter 
 ;Output: (r) .NDC  - Selected NDC Number ("" means no NDC selected)  (Note: REQUIRED for Output value)
 ;
 N SNDC,SYN,Z,IDX,I,PID,DFN,DRGNAM,PRPT,DIR,X,Y
 K ^TMP($J,"PSANDCDP"),^TMP($J,"PSANDCFM")
 ;
 ; - Setting the NDC currently on the PRESCRIPTION (passed in)
 S IDX=0
 I $G(NDC)'="" S IDX=1,^TMP($J,"PSANDCFM",IDX)=NDC,^TMP($J,"PSANDCDP",NDC)=IDX
 ;
 ; - Retrieving NDC from the DRUG/NDF files
 S NDC=$$GETNDC^PSSNDCUT(DRG)
 I NDC'="",'$D(^TMP($J,"PSANDCDP",NDC)) D
 . S IDX=IDX+1,^TMP($J,"PSANDCFM",IDX)=NDC,^TMP($J,"PSANDCDP",NDC)=IDX
 ; 
 ; - Retrieving NDCs from SYNONYMS
 S SYN=0
 F  S SYN=$O(^PSDRUG(DRG,1,SYN)) Q:SYN=""  D
 . S Z=$G(^PSDRUG(DRG,1,SYN,0)),SNDC=$$NDCFMT^PSSNDCUT($P(Z,"^",2)) I SNDC="" Q
 . I $D(^TMP($J,"PSANDCDP",SNDC)) Q
 . S IDX=IDX+1,^TMP($J,"PSANDCFM",IDX)=SNDC
 . S ^TMP($J,"PSANDCDP",SNDC)=IDX
 ;
ASK ; Ask for NDC
 N DIR,Y,DIRUT,DIROUT
 K DIR S DIR(0)="FOA^1:15",DIR("A")="NDC: ",DIR("B")=$G(^TMP($J,"PSANDCFM",1)) I DIR("B")="" K DIR("B")
 S DIR("?")="^D NDCHLP^PSANDCUT"
DEL ; Ask again after deleted
 D ^DIR I X="@" K DIR("B") S NDC="" W "    Deleted!" G DEL
 I $D(DIRUT)!$D(DIROUT) S NDC=$S($D(DIRUT):X,1:"^") G END
 I Y?.N D
 . S NDC=$S($D(^TMP($J,"PSANDCDP",Y)):Y,1:"") I NDC'="" Q
 . S NDC=$S($D(^TMP($J,"PSANDCFM",+Y)):^TMP($J,"PSANDCFM",+Y),1:"") I NDC'="" Q
 . S NDC=Y
 E  S NDC=$TR(Y," ")
 W " ",NDC
 ;
END K ^TMP($J,"PSANDCDP"),^TMP($J,"PSANDCFM")
 Q
 ;
NDCHLP ; Help Text for the NDC Code Selection
 N I
 W !?10,"Select one of the following NDC(s) below:",!
 I $D(^TMP($J,"PSANDCFM")) D
 . S I=0 F  S I=$O(^TMP($J,"PSANDCFM",I)) Q:'I  D
 . . W !?15,$J(I,2)," - ",^TMP($J,"PSANDCFM",I)
 E  W !?12,"<No NDC(s) available for this drug>"
 W !!?10,"Or enter it manually in case the correct"
 W !?10,"NDC is not on the list above."
 Q
