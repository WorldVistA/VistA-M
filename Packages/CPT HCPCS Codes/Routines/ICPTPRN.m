ICPTPRN ;ALB/MTC,RMO,ABR,MRY - CPT PRINT-OUT DRIVER ; 1/03/03 3:21pm
 ;;6.0;CPT/HCPCS;**4,8,9,12,13**;May 19, 1997
 ;
 ;modified to sort in code name order using temp global;abr 1/96
 ;
 ;
AM3 ;-- Recently Inactivated CPT Codes
 N DGDATE,FR,TO,BY
 D INIT
 S DHD="Recently INACTIVATED CPT Codes effective Jan 01, 2003"
 ; rev w/new Inactive Date - changed 2990401 to 3000401 (ERC)
 ;                                              3010401 (JKT)
 ;                                              3020401 (JT)
 ;                                              3030101 (MRY)
 S BY="[ICPT NEW/INACTIVE CODES]",(FR,TO)="3030101,1,"
 D EN1^DIP
 G PRTQ
 ;
AM4 ;-- New CPT Codes
 N DGDATE,FR,TO,BY
 D INIT
 S DHD="NEW CPT Codes effective "_$P(DGDATE,U,2)
 S BY="[ICPT NEW/INACTIVE CODES]",FR=+DGDATE_",@,",TO=+DGDATE_",@,"
 D EN1^DIP
 G PRTQ
 ;
AM5 ;-- Revised CPT Codes
 N DGDATE,DGSRT,FR,TO,BY
 K ^TMP("REVCPT",$J)
 S DGSRT="REVCPT"
 D ^ICPTSR1 ; sorts by revised codes
 D INIT
 S BY(0)="^TMP(""REVCPT"",$J,",L(0)=2,DHD="Recently REVISED CPT Codes effective "_$P(DGDATE,U,2)
 D EN1^DIP
 K ^TMP("REVCPT",$J)
 G PRTQ
 ;
INIT ;--init common items for print routines
 N X,Y
 S (X,DGDATE)=$$CPTDIST^ICPTAPIU,Y="D"
 S $P(DGDATE,U,2)=$$FMTE^XLFDT(X)
 W !,$C(7),"This report requires 132 columns."
 S L=0,DIC="^ICPT(",FLDS="[ICPT PRINT]"
 Q
PRTQ ;--clean-up and exit
 K DHD,FLDS,L,DIC,BY,DIS,ICPTX,ICPTY,ICPTK
 Q
 ;
CPTMOD ; --Modifiers for a range
 ;
 NEW DIC,L,FLDS,BY
 S DIC="^DIC(81.3,",L=0,FLDS="[ICPT MODIFIERS BY RANGE]",BY="[ICPT MODIFIERS FOR RANGE]"
 W !,$C(7),"This report requires 132 columns."
 D EN1^DIP
 Q
