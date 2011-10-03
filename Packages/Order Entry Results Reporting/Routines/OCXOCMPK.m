OCXOCMPK ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Build LIST Function Code cont...) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 Q
 ;
RANGE(ROOT,ELEM,INDEX,PARAM,CD) ;
 ;
 Q:$G(OCXWARN) 1
 N OCXDTYP,FIELD,VARNDX,VARVAL,VARCNT,VSTRT,VSTOP
 S FIELD=$P(PARAM," ",1),VSTRT=$P(PARAM," ",3),VSTOP=$P(PARAM," ",5)
 S VARNDX="OCXLX"_(+INDEX),VARVAL="OCXLV"_(+INDEX),VARCNT="OCXLC"_(+INDEX),VARLIM="OCXLB"_(+INDEX)
 ;
 I '$L($G(ROOT)) D WARN^OCXOCMPV("'RANGE' Function array root not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I '$L($G(ELEM)) D WARN^OCXOCMPV("'RANGE' Function element not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I ($L(PARAM," ")>5) D WARN^OCXOCMPV("'RANGE' Function with too many parameters.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 ;
 S FIELD=$P(PARAM," ",1) I '($E(FIELD,1)="|")!'($E(FIELD,$L(FIELD))="|") D  Q OCXWARN
 .D WARN^OCXOCMPV("'RANGE' Function field name missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 S FIELD=+$P(FIELD,"|",2),OCXDTYP=$$GETDTYP^OCXOCMPI(FIELD)
 ;
 I '$L(VSTRT) D  Q OCXWARN
 .D WARN^OCXOCMPV("'RANGE' Function start value missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I '$L(VSTOP) D  Q OCXWARN
 .D WARN^OCXOCMPV("'RANGE' Function stop value missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 S VSTRT=""""_VSTRT_"""",VSTOP=""""_VSTOP_""""
 I (OCXDTYP="DATE/TIME") S VSTRT="$$INT2DT("_VSTRT_")",VSTOP="$$INT2DT("_VSTOP_")"
 ;
 S CD(1)="; RANGE"
 S CD(2)="S "_VARVAL_"="_VSTRT_","_VARLIM_"="_VSTOP_" D  K "_VARVAL_","_VARLIM_","_VARNDX
 S CD(3)=".D:$L("_VARVAL_")  F  S "_VARVAL_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","_VARVAL_")) Q:'$L("_VARVAL_")  Q:("_VARVAL_"]"_VARLIM_")  D"
 S CD(4)="..S "_VARNDX_"="""" F  S "_VARNDX_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","_VARVAL_","_VARNDX_")) Q:'"_VARNDX_"  D @@@@"
 Q OCXWARN
 ;
ANY(ROOT,ELEM,INDEX,PARAM,CD) ;
 ;
 N OCXDTYP
 I '$L($G(ROOT)) D WARN^OCXOCMPV("'ANY' Function array root not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I '$L($G(ELEM)) D WARN^OCXOCMPV("'ANY' Function element not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I $L(PARAM) D WARN^OCXOCMPV("'ANY' Function does not require parameters.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 S VARNDX="OCXLX"_(+INDEX)
 ;
 S CD(1)="; ANY"
 S CD(2)="S "_(VARNDX)_"="""" F  "_(VARNDX)_"=$O("_ROOT_"""C"","_ELEM_","_(VARNDX)_")) Q:'"_(VARNDX)_"  D @@@@ K "_VARNDX
 ;
 Q OCXWARN
 ;
