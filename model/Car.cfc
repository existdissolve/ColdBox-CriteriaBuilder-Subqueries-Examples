component persistent="true" entityname="Car" table="Car" {
    property name="CarID" column="CarID" type="numeric" ormtype="int" fieldtype="id";
    property name="Make" column="Make" type="string" ormtype="string";
    property name="Model" column="Model" type="string" ormtype="string";
    property name="Year" column="Year" type="numeric" ormtype="int";
    property name="Mileage" column="Mileage" type="numeric" ormtype="int";
    property name="InsuredDrivers" fieldtype="one-to-many" cfc="Driver" fkcolumn="CarID" linktable="Insured" inversejoincolumn="DriverID";
} 