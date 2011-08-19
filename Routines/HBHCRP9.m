HBHCRP9 ; LR VAMC(IRMS)/MJT-HBHC rpt, file 632, All or multi prov census by date range, includes: Prov, Pt Name, SSN, Adm Date, Address, City, ZIP Code, & Phone, Totals for Prov & All, calls PROV^HBHCUTL2, EN^HBHCUTL2, & EN2^HBHCUTL2 ; Aug 2000
 ;;1.0;HOSPITAL BASED HOME CARE;**16,14**;NOV 01, 1993
 S HBHCC=20,HBHCFILE=632,HBHCXREF="C"
 D PROV^HBHCUTL2,EN^HBHCUTL2,EN2^HBHCUTL2
EXIT ; Exit module
 Q
