JLV29P1 ;;HON/JLV - JLV Pre-install for JLV 2.9 p1;;6/19/20 13:15
 ;;2.9;JOINT LEGACY VIEWER;**1**;JUN 10, 2020;Build 6
 ;; ICR in use: #2067 XPDIP
 ;; update CURRENT VERSION field in PACKAGE File to 2.9
 ; Find PACKAGE File IEN for JLV
 N JLVPKG,JLVVER
 S JLVPKG=$$FIND1^DIC(9.4,"","MX","JLV","","","ERR")
 I JLVPKG=0 D  Q
 . W !,"PACKAGE File Entry not found. CURRENT VERSION not set."
 ; set version
 S JLVVER=$$PKGVER^XPDIP(JLVPKG,"2.9^3200611^"_DT_"^"_DUZ)
 I JLVVER>0 W !!,"CURRENT VERSION field set to 2.9 in PACKAGE file"
 Q
