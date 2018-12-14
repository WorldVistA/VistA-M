VPRP11I ;SLC/MKB -- VPR patch 11 post install ;10/14/18  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**11**;Sep 01, 2011;Build 6
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D PUT^XPAR("PKG","VPR VERSION",1,"1.11")
 Q
