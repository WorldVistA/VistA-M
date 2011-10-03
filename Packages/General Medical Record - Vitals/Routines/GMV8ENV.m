GMV8ENV ;;HIOFO/FT-GMRV*5*8 ENVIRONMENT ROUTINE ;3/24/05  16:26
 ;;5.0;GEN. MED. REC. - VITALS;**8**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; 10141 - XPDUTL          (supported)
 ;
EN1 ;
 I '$$VERSION^XPDUTL("HDI") S XPDQUIT=2
 Q
