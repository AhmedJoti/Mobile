package ma.gemo.cinema.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Stream;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ma.gemo.cinema.dao.CategorieRepository;
import ma.gemo.cinema.dao.CinemaRepository;
import ma.gemo.cinema.dao.FilmRepository;
import ma.gemo.cinema.dao.PlaceRepository;
import ma.gemo.cinema.dao.ProjectionRepository;
import ma.gemo.cinema.dao.SalleRepository;
import ma.gemo.cinema.dao.SeanceRepository;
import ma.gemo.cinema.dao.TickeRepository;
import ma.gemo.cinema.dao.VilleRepository;
import ma.gemo.cinema.entities.Categorie;
import ma.gemo.cinema.entities.Cinema;
import ma.gemo.cinema.entities.Film;
import ma.gemo.cinema.entities.Place;
import ma.gemo.cinema.entities.Projection;
import ma.gemo.cinema.entities.Salle;
import ma.gemo.cinema.entities.Seance;
import ma.gemo.cinema.entities.Ticket;
import ma.gemo.cinema.entities.Ville;

@Service
@Transactional
public class CinemaInitServiceImpl implements ICinemaInitService{

	@Autowired
	private VilleRepository villeRepository;
	@Autowired
	private CinemaRepository cinemaRepository;
	@Autowired
	private SalleRepository salleRepository;
	@Autowired
	private PlaceRepository placeRepository;
	@Autowired
	private SeanceRepository seanceRepository;
	@Autowired
	private FilmRepository filmRepository;
	@Autowired
	private CategorieRepository categorieRepository;
	@Autowired
	private ProjectionRepository projectionRepository;
	@Autowired
	private TickeRepository ticketRepository;
	
	@Override
	public void initVilles() {
		Stream.of("Casablanca","Marrakech","Rabat","Tanger").forEach(nameVille->{
			Ville ville = new Ville();
			ville.setName(nameVille);
			villeRepository.save(ville);
//			villeRepository.save(new Ville(null,v));
		});		
	}

	@Override
	public void initCinemas() {
		villeRepository.findAll().forEach(v->{
			
			Stream.of("Megarama","Imax","FOUNOUN","Dawliz","Chahrazad").forEach(nameCinema->{
			Cinema cinema = new Cinema();
			cinema.setName(nameCinema);
			cinema.setVille(v);
			cinema.setNombreSalles(3+((int)(Math.random()*7)));
			cinemaRepository.save(cinema);
		});
	});
	}
	
	
	@Override
	public void initSalles() {
		cinemaRepository.findAll().forEach(cinema->{
			
			for(int i=0;i<cinema.getNombreSalles();i++) {
				
				Salle salle = new Salle();
				salle.setCinema(cinema);
				salle.setName("Salle"+(i+1));
				salle.setNombrePlaces(15+((int)(Math.random()*20)));
				salleRepository.save(salle);

								
			}
		});
	}

	@Override
	public void initPlaces() {

		salleRepository.findAll().forEach(salle->{
			
			for(int i=0;i<salle.getNombrePlaces();i++) {
				Place place = new Place();
				place.setNumero((i+1));
				place.setSalle(salle);
				placeRepository.save(place);
				
			}
			
		});
		
		
		
	}

	@Override
	public void initSeances() {
		DateFormat dateFormat = new SimpleDateFormat("HH:mm");
       Stream.of("12:00","15:00","17:00","19:00","21:00").forEach(s->{
    	   
    	   Seance seance =new Seance();
    	   try {
			seance.setHeureDebut(dateFormat.parse(s));
			seanceRepository.save(seance);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	   
    	   
    	   
       });		
	}

	@Override
	public void initCategories() {
		   Stream.of("Histoire","Drama","Suspence","Action").forEach(c->{
	    	   
			   Categorie categorie =new Categorie();
	   
			   categorie.setName(c);
			   categorieRepository.save(categorie);
			   });
		
	}

	@Override
	public void initFilms() {
		 double[] durees = new double[] {1,1.5,2,2,5,3};
		 List<Categorie> categories=categorieRepository.findAll();
		 Stream.of("seigneurs des anneaux","game of thrones","dont breathe","saw","le parrain","la ligne verte","jaws").forEach(f->{
	    	  
			   Film film =new Film();
	   
			   film.setTitre(f);
			   film.setDuree(durees[new Random().nextInt(durees.length)]);
			   film.setPhoto(f.replace(" ","_"));
			   film.setCategorie(categories.get(new Random().nextInt(categories.size())));
			   filmRepository.save(film);
			   });
		
	}

	@Override
	public void initProjections() {
		 double[] prices = new double[] {20,30,35,45,55,65};
	  List<Film> films=filmRepository.findAll();
		villeRepository.findAll().forEach(ville->{
			System.err.println("ville"+ville);
           ville.getCinemas().forEach(cinema->{

        	   cinema.getSalles().forEach(salle->{
                  int index =new Random().nextInt(films.size());
                  Film film = films.get(index);
//        		   filmRepository.findAll().forEach(film->{

        			   seanceRepository.findAll().forEach(seance->{

        				   Projection projection = new Projection();
        				   projection.setDateProjection(new Date());
        				   projection.setFilm(film);
        				   projection.setPrix(prices[new Random().nextInt(prices.length)]);
        				   projection.setSalle(salle);
        				   projection.setSeance(seance);
        				   projectionRepository.save(projection);
        				   
        				   
//        			   });
        			   
        			   
        		   });
        		   
        	   });
           });
		 });
	}
	
	@Override
	public void initTickets() {
		projectionRepository.findAll().forEach(p->{
			p.getSalle().getPlaces().forEach(place->{
				Ticket ticket = new Ticket();
				ticket.setPlace(place);
				ticket.setReserve(false);
				ticket.setPrix(p.getPrix());
				ticket.setProjection(p);
				ticketRepository.save(ticket);
			});
			
		});
	}

}
