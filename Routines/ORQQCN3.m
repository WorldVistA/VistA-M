ORQQCN3 ; slc/REV - RPCs for Consults/Medicine Resulting ;01:56 PM  12 May 2000
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85**;Dec 17, 1997
 ;
GETMED(ORY,GMRCO)       ; Return available med results for proc request
 Q:+$G(GMRCO)=0
 D GETMED^GMRCGUIU(GMRCO,.ORY)
 Q
MEDCOMP(ORY,GMRCO,GMRCRSLT,GMRCAD,GMRCORNP,ORALTO) ; Attach a medicine result to a consult
 ;GMRCO - Internal file number of consult from File 123
 ;GMRCRSLT - pointer to medicine result
 ;GMRCAD - Date/Time Consult was resulted.
 ;GMRCORNP - Provider who attached the result to the consult
 ;ORALTO - array of alert recipient IENs
 Q:+$G(GMRCO)=0
 N ORDUZ,X,I
 I $G(ORALTO)'="" D
 .F I=1:1  S X=$P(ORALTO,";",I) Q:X=""  S ORDUZ(X)=""
 D MEDCOMP^GMRCMED(GMRCO,GMRCRSLT,GMRCAD,GMRCORNP,.ORDUZ)
 Q
GETRES(ORY,GMRCO)       ; return array of associated med results
 Q:+$G(GMRCO)=0
 D GETRES^GMRCGUIU(GMRCO,.ORY)
 Q
REMOVE(ORY,GMRCO,GMRCRSLT,GMRCAD,GMRCORNP) ; Remove a medicine result from a consult
 ;GMRCO - Internal file number of consult from File 123
 ;GMRCRSLT - pointer to medicine result
 ;GMRCAD - Date/Time medicine result was removed
 ;GMRCORNP - Provider who removed the result from the consult
 Q:+$G(GMRCO)=0
 D REMOVE^GMRCDIS(GMRCO,GMRCRSLT,GMRCAD,GMRCORNP)
 Q
DISPMED(ORY,GMRCRES)    ; Detailed display of a med result
 Q:+$G(GMRCRES)=0
 D DISPMED^GMRCGUIU(GMRCRES,.ORY)
 Q
  
