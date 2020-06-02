package ma.gemo.cinema.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.Data;
import ma.gemo.cinema.dao.FilmRepository;
import ma.gemo.cinema.dao.TickeRepository;
import ma.gemo.cinema.entities.Film;
import ma.gemo.cinema.entities.Ticket;

@RestController
@CrossOrigin("*")
public class CinemaRestController {
	@Autowired
	private FilmRepository filmrepository;
	@Autowired
	private TickeRepository ticketRepository;
    
	@GetMapping(path="/imageFilm/{id}",produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] image(@PathVariable(name="id") Long id) throws Exception{
			
		Film f=filmrepository.findById(id).get();
		String photoName = f.getPhoto();
	
		File file = new File("C:\\cinema\\images\\"+photoName+".png");
		Path path = Paths.get(file.toURI());
		return Files.readAllBytes(path);
	}
	
	@PostMapping("/payerTickets")
	@Transactional
	public List<Ticket> payerTickets(@RequestBody TicketForm ticketform){
		
		List<Ticket> listTickets=new ArrayList<>();
		ticketform.getTickets().forEach(idTicket->{			
			
			Ticket ticket = ticketRepository.findById(idTicket).get();
			ticket.setNomClient(ticketform.getNomClient());
 
			ticket.setReserve(true);
			ticket.setCodePaiement(ticketform.getCodePayement());
			ticketRepository.save(ticket);
			listTickets.add(ticket);
		});
		return listTickets;
	}
	 
	@Data
	static class TicketForm{
		private String nomClient;
		private int codePayement;
		private List<Long> tickets = new ArrayList<>();
		
	}
	
}
