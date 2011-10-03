GMRAOR0 ;HIRMFO/WAA,FPT-OERR HL7 UTILITY ; 2/9/95
 ;;4.0;Adverse Reaction Tracking;**4**;Mar 29, 1996
DUPCHK(DFN,GMRALL) ;CHECK FOR DUPS
 ;Input variable:
 ;         DFN = Patient DFN
 ;      GMRALL = Free text of allergy
 ;
 ;return variable:
 ;     GMRAFLG = (0,1,-1)
 ;               0   Patient has no matching reactions on file
 ;               1   Patient has a matching reaction.
 ;              -1   Patient has a matching reaction but is E/E
 ;
 ;********************************************************************
 N GMRAFLG,GMRAPA
 S GMRAFLG=0,GMRAPA=0
 ;Loop through all the patient's reaction and look for matches
 F  S GMRAPA=$O(^GMR(120.8,"B",DFN,GMRAPA)) Q:GMRAPA<1  D  Q:GMRAFLG=1
 .Q:GMRALL'=$P($G(^GMR(120.8,GMRAPA,0)),U,2)  ;Not a match
 .I +$G(^GMR(120.8,GMRAPA,"ER")) S GMRAFLG=-1 Q  ;E/E
 .S GMRAFLG=1 ;Matching allergy.
 .Q
 Q GMRAFLG
