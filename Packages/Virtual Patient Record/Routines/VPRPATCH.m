VPRPATCH ;SLC/MKB -- VPR patch post install ;8/14/13  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**7**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 N P,N S P=+$P($G(XPDNM),"*",3) I P D  ;update version#
 . S N="1."_$S(P<10:"0",1:"")_P
 . D PUT^XPAR("PKG","VPR VERSION",1,N)
 Q
