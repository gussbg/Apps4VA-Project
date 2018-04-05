/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

/**
 *
 * @author Brendon Guss
 */
public class RacePercentDatum {
    
    private String race;
    private final int count;
    private final double density;
    
    public RacePercentDatum(int race, int count, double density)
    {
        
        switch(race)
        {
            case 0:
                this.race = "Unspecified";
                break;
            case 1:
                this.race = "American Indian/Alaska Native";
                break;
            case 2:
                this.race = "Asian";
                break;
            case 3:
                this.race = "Black/African American";  
                break;
            case 4:
                this.race = "Hispanic of any Race"; 
                break;
            case 5:
                this.race = "White";
                break;
            case 6:
                this.race = "Native Hawaiian/Other Pacific Islander";
                break;
            case 99:
                this.race = "Two or more Races, Non-Hispanic";
                break;
        }
        this.count = count;
        this.density = density;
    }
    
    public String getRace()
    {
        return race;
    }
    
    public double getDensity()
    {
        return density;
    } 
}