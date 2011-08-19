HBHCRP6 ; LR VAMC(IRMS)/MJT-HBHC rpt, file 631, All or multi case mgr census by date range, includes: Case Manager, Pat Name, SSN, Adm Date, Address, City, ZIP Code, & Phone, Totals for Case Mgr & All, calls EN^HBHCUTL2 & EN2^HBHCUTL2 ; Aug 2000
 ;;1.0;HOSPITAL BASED HOME CARE;**16,14**;NOV 01, 1993
 S HBHCWHO="case manager",HBHCWHOS="case managers",HBHCWHOC="Case Manager",HBHCFILE=631,HBHCXREF="AD",HBHCC=24
 D EN^HBHCUTL2,EN2^HBHCUTL2
EXIT ; Exit module
 Q
