LRBLJP ;AVAMC/REG - BB INVENTORY PRINT OPTS ;3/9/94  13:03 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
S K DIC W ! S DIC=65,DIC(0)="AEFQM" D ^DIC G:X=""!(X[U) END S DIC="^LRD(65,",DA=+Y,DR="0:ZZ" D EN^DIQ G S
 ;
P W ! S DIC=65,DIC(0)="AEFQM",L=0 D ^DIC G:X=""!(X[U)!($A(X)=46) END S X=$P(Y,U,2),FLDS="[CAPTIONED]",BY="UNIT ID",(FR,TO)=X,DHD="Unit inquiry "_$$INS^LRU D EN1^DIP K DIC Q
 ;
T W !!?27,"TYPING CHARGE LIST",!! D EDC,LRSTAR G:Y<0 END S L=0,DIC="^LRD(65,",FLDS="[LRBLDSP]",BY="DATE/TIME RECEIVED,TYPING CHARGE",FR=LRSDT,TO=LRLDT K %ZIS D EN1^DIP K DIC Q
 ;
I D SET,EDC W @IOF,?27,"SUPPLIER INVOICE LIST",!! S L=0,DIC="^LRD(65,",(FLDS,BY)="[LRBLINV]",DHD="Blood inventory list "_$$INS^LRU K %ZIS D EN1^DIP K DIC Q
 ;
LRSTAR D B^LRU Q:Y<1
 S DIC="^LRD(65,",L=0,DHD="From: "_LRSTR_" To: "_LRLST Q
 ;
EDC W ! W $S(LROPT="I":"Edit Supplier charges before listing invoices?  NO// ",1:"Edit Supplier typing charges before listing ?  NO// ") R X:DTIME Q:X=""!(X[U)!(X?1"N".E)  G EDC:X'?1"Y".E
UNIT S (DIC,DIE)=65,DIC(0)="AEFQM",DIC("A")="Select donor unit: " D ^DIC G:X=""!(X[U) END S DA=+Y,DR=$S(LROPT="I":.1,1:.12) D ^DIE G UNIT
SET S %DT="",X="T" D ^%DT,D^LRU S LRH(0)=Y S IOP="HOME" D ^%ZIS Q
 ;
END D V^LRU Q
