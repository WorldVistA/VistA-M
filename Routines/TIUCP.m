TIUCP ;SLC/RMO - Clinical Procedures API(s) and RPC(s) ;5/12/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**109,182**;Jun 20, 1997
 ;
CLASS() ;Get the CLINICAL PROCEDURES Class TIU Document Definition
 ;file (#8925.1) IEN
 ; Input  -- None    
 ; Output -- TIU Document Definition file (#8925.1) IEN
 N Y,TIUI,TYPE
 S (Y,TIUI)=0
 ; -- Make sure type is CLASS (P182):
 F  S TIUI=+$O(^TIU(8925.1,"B","CLINICAL PROCEDURES",TIUI)) Q:'TIUI  D  Q:Y
 . S TYPE=$P($G(^TIU(8925.1,TIUI,0)),U,4)
 . I TYPE="CL" S Y=TIUI
 Q Y
 ;
HISTDC() ;Get Historical Procedures Document Class IEN (under Class CLINICAL PROCEDURES) in TIU DDEF file (#8925.1)
 ; -- P182
 ; Input  -- None    
 ; Output -- TIU Document Definition file (#8925.1) IEN
 N Y,TIUI,TYPE,TIUISCP
 S (Y,TIUI)=0
 F  S TIUI=+$O(^TIU(8925.1,"B","HISTORICAL PROCEDURES",TIUI)) Q:'TIUI  D  Q:Y
 . S TYPE=$P($G(^TIU(8925.1,TIUI,0)),U,4)
 . I TYPE="DC" D ISCP(.TIUISCP,TIUI) S:TIUISCP Y=TIUI
 Q Y
 ;
ISHISTCP(TITLE) ; Function evaluates whether a Title is under the
 ;Historical Procedures Document Class under Class CP
 ; -- P182
 ; Input  -- TITLE    TIU Document Definition file (#8925.1) IEN
 ; Output -- 1=True and 0=False
 N TIUDCLAS,Y
 ; -- Exit if Title is not defined:
 I $G(TITLE)'>0 S Y=0 G ISHISTX
 ; -- Get HISTORICAL PROCEDURES Document Class IEN in 8925.1:
 S TIUDCLAS=$$HISTDC
 ; -- Exit if Document Class is not found:
 I TIUDCLAS'>0 S Y=0 G ISHISTX
 ; -- Check if Title is under HISTORICAL PROCEDURES Document Class:
 S Y=+$$ISA^TIULX(TITLE,TIUDCLAS)
ISHISTX Q Y
 ;
HPCAN(TIUACT) ; Is action allowed (not prohibited outright) for HP docmts
 ; Returns 1 if action allowed (not prohibited outright)
 ;         0^WHYNOT if action not allowed (prohibited outright)
 ; Requires TIUACT=IEN in USR ACTION file
 N ALLOWED S ALLOWED=1
 I TIUACT=19 S ALLOWED="0^ Historical Procedures may not be addended."
 I TIUACT=20 S ALLOWED="0^ Historical Procedures may not have signers identified."
 I TIUACT=21 S ALLOWED="0^ Historical Procedures may not be reassigned."
 I TIUACT=22 S ALLOWED="0^ Historical Procedures may not have their titles changed."
 I TIUACT=23 S ALLOWED="0^ Historical Procedures may not be linked with requests."
 Q ALLOWED
 ;
ISCP(TIUY,TITLE) ;RPC that evaluates whether or not a Title is under
 ;the CLINICAL PROCEDURES Class
 ; Input  -- TITLE    TIU Document Definition file (#8925.1) IEN
 ;                    (May be Document Class instead of Title.)
 ; Output -- TIUY     1=True and 0=False
 N TIUCLASS
 ;
 ;Exit if a Title is not defined
 I +$G(TITLE)'>0 S TIUY=0 G ISCPQ
 ;
 ;Get CLINICAL PROCEDURES TIU Document Definition file (#8925.1) IEN
 S TIUCLASS=+$$CLASS
 ;
 ;Exit if the CLINICAL PROCEDURES Class is not found
 I +TIUCLASS'>0 S TIUY=0 G ISCPQ
 ;
 ;Check if the Title is under the CLINICAL PROCEDURES Class
 S TIUY=+$$ISA^TIULX(TITLE,TIUCLASS)
ISCPQ Q
 ;
CPCLASS(Y) ;RPC that gets the CLINICAL PROCEDURES TIU Document
 ;Definition file (#8925.1) IEN
 ; Input  -- None
 ; Output -- Y        TIU Document Definition file (#8925.1) IEN
 S Y=$$CLASS
 Q
 ;
LNGCP(Y,FROM,DIR) ;RPC that serves data to a longlist of selectable Titles
 ; Input  -- FROM     Reference Title from which the longlist is
 ;                    scrolling
 ;           DIR      Direction from which the longlist is scrolling
 ;                    from the reference Title  (Optional- default 1)
 ; Output -- Y        An array of the 44 nearest Titles to that indicated
 ;                    by the user in the direction passed by the longlist
 ;                    component
 N TIUCLASS
 ;
 ;Exit if a reference Title is not defined
 I '$D(FROM) G LNGCPQ
 ;
 ;Get CLINICAL PROCEDURES TIU Document Definition file (#8925.1) IEN
 S TIUCLASS=+$$CLASS
 ;
 ;Exit if the CLINICAL PROCEDURES Class is not found
 I +TIUCLASS'>0 G LNGCPQ
 ;
 ;Get the longlist of Titles for the CLINICAL PROCEDURES Class
 D LONGLIST^TIUSRVD(.Y,TIUCLASS,FROM,$G(DIR,1))
LNGCPQ Q
