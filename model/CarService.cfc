/**
* A ColdBox Enabled virtual entity service
*/
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton{
	/**
	* Constructor
	*/
	CarService function init(){
		// init super class
		super.init( entityName="Car" );
	    return this;
	}
	
	// page2
	public struct function getSimpleJoin( required Numeric Age ) {
		var c = newCriteria();
		c.createAlias( "InsuredDrivers", "id" ).isGT( "id.Age", javaCast( "int", arguments.Age ) );
		var results = {
			count = c.count(),
			data = c.list( asquery=true )
		};
		return results;
	}
	
	// page3
	public struct function getSimpleJoinTransform( required Numeric Age ) {
		var c = newCriteria();
        c.createAlias( "InsuredDrivers", "id" )
            .isGt( "id.Age", javaCast( "int", arguments.Age ) )
            .resultTransformer( c.DISTINCT_ROOT_ENTITY );
        var results = {
            data = c.list( asquery=true ),
            count = c.count()
        };
        return results;
	}
	
	// page4
	public struct function getSimpleJoinSQLRestriction( required Numeric Age ) {
		var c = newCriteria();
        	c.sqlRestriction( "CarID in ( select CarID from Insured i join Driver d on i.DriverID=d.DriverID where d.Age > #arguments.Age# )" );
        var results = {
            data = c.list( asquery=true ),
            count = c.count()
        };
        return results;
	}
	
	// page6
	public struct function getSimpleSubquery( required Numeric Age ) {
		var c = newCriteria();
        	c.add(
        		c.createSubcriteria( "Car", "CarSub" )
        		 .withProjections( property="CarID" )
        		 .createAlias( "InsuredDrivers", "id" )
        		 .isGT( "id.Age", javaCast( "int", arguments.Age) )
        		 .propertyIn( "CarID" )
        	);
        var results = {
            data = c.list( asquery=true ),
            count = c.count()
        };
        return results;
	}
	
	// page8
	public struct function getSQLProjection( required Numeric Age ) {
		var c = newCriteria();
        	c.add(
        		c.createSubcriteria( "Car", "CarSub" )
        		 .withProjections( property="CarID" )
        		 .createAlias( "InsuredDrivers", "id" )
        		 .isGT( "id.Age", javaCast( "int", arguments.Age) )
        		 .propertyIn( "CarID" )
        	)
        	.withProjections(
        		sqlProjection=[
        			{
                		sql = "select count(*) from Car where Year < 2006 and CarID={alias}.CarID",
                		alias = "TotalMakePre2006",
                		property="Year"
            		},
            		{
                		sql = "select count(*) from Car where Year > 2005 and CarID={alias}.CarID",
                		alias = "TotalMakePost2005",
                		property="Year"
            		}
        		],
        		groupProperty="Make"
        	);
        var results = {};
        	results.data = c.list();
        	results.count= arrayLen( results.data );
        return results;
	}
	
	// page8
	public struct function getSQLGroupProjection( required Numeric Age ) {
		var c = newCriteria();
        	c.add(
        		c.createSubcriteria( "Car", "CarSub" )
        		 .withProjections( property="CarID" )
        		 .createAlias( "InsuredDrivers", "id" )
        		 .isGT( "id.Age", javaCast( "int", arguments.Age) )
        		 .propertyIn( "CarID" )
        	)
        	.withProjections(
        		sqlGroupProjection=[
        			{
                		sql = "select count(*) from Car where Year < 2006 and CarID={alias}.CarID",
                		alias = "TotalMakePre2006",
                		property="Year",
                		group="Model,Make"
            		},
            		{
                		sql = "sum((select count(*) from Car where Year > 2005 and CarID={alias}.CarID))",
                		alias = "TotalMakePost2005",
                		property="Year",
                		group="Model"
            		}
        		],
        		property="Make,Model"
        	);
        var results = {};
        	results.data = c.list();
        	results.count= arrayLen( results.data );
        return results;
	}
	
	// page9
	public struct function getDetachedCriteriaSQLProjection( required Numeric Age ) {
		var c = newCriteria();
        	c.add(
        		c.createSubcriteria( "Car", "CarSub" )
        		 .withProjections( property="CarID" )
        		 .createAlias( "InsuredDrivers", "id" )
        		 .isGT( "id.Age", javaCast( "int", arguments.Age) )
        		 .propertyIn( "CarID" )
        	)
        	.withProjections(
        		detachedSQLProjection=[
        			c.createSubcriteria( "Car", "Car2" )
        			 .withProjections( count="Car2.Year" )
        			 .isLT( "Year", javaCast( "int", 2006 ) )
        			 .isEQ( "CarID", "{alias}.CarID" ),
            		c.createSubcriteria( "Car", "Car3" )
        			 .withProjections( count="Car3.Year" )
        			 .isGT( "Year", javaCast( "int", 2005 ) )
        			 .isEQ( "CarID", "{alias}.CarID" )
        		],
        		groupProperty="Make"
        	);               
        var results = {};
        	results.data = c.list();
        	results.count= arrayLen( results.data );
        return results;
	}
}