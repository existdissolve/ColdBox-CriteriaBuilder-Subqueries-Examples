component persistent="true" table="Insured" {
    property name="InsuredID" column="InsuredID" type="numeric" ormtype="int" fieldtype="id";
    
    property name="DriverID" fieldtype="many-to-one" cfc="Driver" fkcolumn="DriverID";
    property name="CarID" fieldtype="many-to-one" cfc="Car" fkcolumn="CarID";
} 