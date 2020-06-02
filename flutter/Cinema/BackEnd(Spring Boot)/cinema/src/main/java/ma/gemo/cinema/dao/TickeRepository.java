package ma.gemo.cinema.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import ma.gemo.cinema.entities.Ticket;
@RepositoryRestResource
@CrossOrigin("*")

public interface TickeRepository extends JpaRepository<Ticket, Long> {

}
