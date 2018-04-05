package db;

/**
 * @author Brendon Guss
 */
public class TestDatum {
    
    private final String subject;
    private final int score;
    private final int year;
    
    public TestDatum(String subject, int score, int year)
    {
        this.subject = subject;
        this.score = score;
        this.year = year;
    }
    
    public String getSubject()
    {
        return subject;
    }
    
    public int getScore()
    {
        return score;
    }
    
    public int getYear()
    {
        return year;
    }
}
