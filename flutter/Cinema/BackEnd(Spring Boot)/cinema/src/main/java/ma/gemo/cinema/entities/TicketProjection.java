package ma.gemo.cinema.entities;



import java.util.Collection;
import java.util.Date;

import org.springframework.data.rest.core.config.Projection;

@Projection(name="ticketProj",types= {Ticket.class})
public interface TicketProjection {
	public Long getId();
	public String getNomClient();
    public double getPrix();
    public Integer getCodePaiement();
    public boolean getReserve();
    public Place getPlace();

}
