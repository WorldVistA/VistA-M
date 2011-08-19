GMTSRI ; SLC/DLT,KER - Health Summary Type Inquiry ; 08/27/2002
 ;;2.7;Health Summary;**30,56**;Oct 20, 1995
 ;                      
 ; External References
 ;   DBIA 10010  EN1^DIP
 ;                     
EN ; Inquire/Display a Health Summary Type
 S U="^",DIC="^GMT(142,",DIC(0)="AEMQF"
 S DIC("A")="Select Health Summary Type: "
 S Y=$$TYPE^GMTSULT K DIC("A") G:Y=-1!(Y=U) END S (FR,TO)=$P(Y,"^",2)
 S BY=".01",DHD="[GMTS TYPE INQ HEADER]-[GMTS TYPE INQ FOOTER]"
 S FLDS="[GMTS TYPE INQ]" S L=0 D EN1^DIP
END ; End/Quit without Display
 Q
