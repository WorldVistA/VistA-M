GMTSP114 ;CIO/SLC - Post Install GMTS*2.7*114 ;08/03/15  14:27
 ;;2.7;Health Summary;**114**;Oct 20, 1995;Build 11
 Q
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="DIM;SIM;SIMC;SIMR"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 D LIM
 I +$$ROK("GMTSXPS1")>0 D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*114" D SEND^GMTSXPS1
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))  S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX
 Q:'$L(GMTSTXT) 0  Q 1
 ;                
DIM ; Immunizations Detail Component Data
 ;0;;218
 ;.01;;PCE IMMUNIZATIONS DETAILED
 ;1;;IMMUND;GMTSPXIM
 ;1.1;;0
 ;2;;
 ;3;;DIM
 ;3.5;;9
 ;3.5;1;This component lists the immunizations (e.g., Rubella, Smallpox,
 ;3.5;2;etc.) and information about each immunization administered to a
 ;3.5;3;particular patient in detail. Data are sorted in alphabetical order by
 ;3.5;4;immunization name and then by administration date in reverse chronological
 ;3.5;5;order. Data are presented in a Fileman captioned style and include
 ;3.5;6;immunization name, full name, series, administration date, facility,
 ;3.5;7;reaction, contraindications, manufacturer, lot number, expiration date,
 ;3.5;8;dosage, administration route, administration site, vaccine information
 ;3.5;9;statements offered to the patient, administered by and comments.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Immunizations Detail
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
SIM ; Immunizations Select Component Data
 ;0;;219
 ;.01;;PCE IMMUNIZATIONS SELECTED
 ;1;;IMMUN;GMTSPXIM
 ;1.1;;0
 ;2;;Y
 ;3;;SIM
 ;3.5;;14
 ;3.5;1;This component lists the immunizations (e.g., Rubella, Smallpox,
 ;3.5;2;etc.) and information about each immunization administered to a particular
 ;3.5;3;patient. Time and maximum occurrence limits apply, and the user is allowed
 ;3.5;4;to select any number of the immunizations defined in the Immunization
 ;3.5;5;(#9999999.14) file. The user may select a time limit up to 99 years and
 ;3.5;6;999 maximum occurrences. Data are displayed in alphabetical order by
 ;3.5;7;immunization name and then by administration date in reverse 
 ;3.5;8;chronological order. Data presented include immunization name, series,
 ;3.5;9;administration date and facility. If there is a reaction and/or
 ;3.5;10;contraindication, the record is marked with a '<**>'. The name of the
 ;3.5;11;immunization, date of administration and reaction/contraindications are
 ;3.5;12;displayed at the end of the display. If the record has a comment it is
 ;3.5;13;marked with a '<C>'. Comments can be viewed in the Detailed Immunizations
 ;3.5;14;Health Summary component. 
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;9999999.14
 ;8;;
 ;9;;Immunizations Select
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;TIM;;99Y
 ;OCC;;999
 ;
 Q
 ;
SIMC ; Immun Select Old>New Component Data
 ;0;;221
 ;.01;;PCE IMMUNIZATIONS SELECT CHRON
 ;1;;IMMUNCDT;GMTSPXIM
 ;1.1;;0
 ;2;;Y
 ;3;;SIMC
 ;3.5;;13
 ;3.5;1;This component lists the immunizations (e.g., Rubella, Smallpox, etc.) and
 ;3.5;2;information about each immunization administered to a particular patient.
 ;3.5;3;Time and maximum occurrence limits apply, and the user is allowed to
 ;3.5;4;select any number of the immunizations defined in the Immunization
 ;3.5;5;(#9999999.14) file. The user may select a time limit up to 99 years and
 ;3.5;6;999 maximum occurrences. Data are displayed by administration date in
 ;3.5;7;chronological order and then alphabetically by immunization name. Data
 ;3.5;8;presented include immunization name, series, administration date and
 ;3.5;9;facility. If there is a reaction and/or contraindication, the record is
 ;3.5;10;marked with a '<**>'. The name of the immunization, date of administration
 ;3.5;11;and reaction/contraindications are displayed at the end of the display. If
 ;3.5;12;the record has a comment it is marked with a '<C>'. Comments can be viewed
 ;3.5;13;in the Detailed Immunizations Health Summary component.
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;9999999.14
 ;8;;
 ;9;;Immun Select Old>New
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;TIM;;99Y
 ;OCC;;999
 ;
 Q
 ;
SIMR ; Immun Select New>Old Component Data
 ;0;;222
 ;.01;;PCE IMMUN SELECT REVERSE CHRON
 ;1;;IMMUNRDT;GMTSPXIM
 ;1.1;;0
 ;2;;Y
 ;3;;SIMR
 ;3.5;;13
 ;3.5;1;This component lists the immunizations (e.g., Rubella, Smallpox, etc.) and
 ;3.5;2;information about each immunization administered to a particular patient.
 ;3.5;3;Time and maximum occurrence limits apply, and the user is allowed to
 ;3.5;4;select any of the immunizations defined in the Immunization (#9999999.14)
 ;3.5;5;file. The user may select a time limit up to 99 years and 999 maximum
 ;3.5;6;occurrences. Data are displayed by administration date in reverse
 ;3.5;7;chronological order and then alphabetically by immunization name. Data
 ;3.5;8;presented include immunization name, series, administration date and
 ;3.5;9;facility. If there is a reaction and/or contraindication, the record is
 ;3.5;10;marked with a '<**>'. The name of the immunization, date of administration
 ;3.5;11;and reaction/contraindications are displayed at the end of the display. If
 ;3.5;12;the record has a comment it is marked with a <C>. Comments can be viewed
 ;3.5;13;in the Detailed Immunizations Health Summary component.
 ;4;;Y
 ;5;;
 ;6;;
 ;7;;1
 ;7;1;9999999.14
 ;8;;
 ;9;;Immun Select New>Old
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;TIM;;99Y
 ;OCC;;999
 ;
 Q
 ;
