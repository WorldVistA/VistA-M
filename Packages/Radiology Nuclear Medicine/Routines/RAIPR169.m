RAIPR169 ;HISC/GJC- RA*5.0*169 Pre-init routine ; Apr 24, 2020@12:11:29
VERSION ;;5.0;Radiology/Nuclear Medicine;**169**;Mar 16, 1998;Build 2
 ;
 ;Component       Type         IA       Usage
 ;-------------------------------------------
 ;UNC^DIEZ        routine      3476     (C)
 ;INPUT TEMPLATE  file (#.402) 2022     (C)
 ;
UNC751 ; Un-compile the RA ORDER EXAM (^RACTOE*) & RA QUICK EXAM ORDER (^RACTQE*)
 ; input templates and their compiled routines. File: RAD/NUC MED ORDERS (#75.1).
 ; Variable Definition:
 ;
 K RAX,RAY F RAX="RA QUICK EXAM ORDER","RA ORDER EXAM" D
 .S RAY=$$FIND1^DIC(.402,"","X",RAX)
 .I RAY=0 D  Q
 ..D BMES^XPDUTL("Input template '"_RAX_"' not found.")
 ..Q
 .D MSG,UNC^DIEZ(RAY,"D")
 .Q
 ;
 K RAX,RAY
 Q
MSG ; Build the text array for each specific compiled input template deleted.
 ; Input: RAX-the name of the input template (75.1)
 S RATXT(1)=""
 S RATXT(1)="Un-compiling the '"_RAX_"' input template associated with the"
 S RATXT(2)="RAD/NUC MED ORDERS (#75.1) file.  All the compiled template routines"
 S RATXT(3)="associated with '"_RAX_"' will be deleted.",RATXT(4)=""
 D BMES^XPDUTL(.RATXT) K RATXT
 Q
 ;
