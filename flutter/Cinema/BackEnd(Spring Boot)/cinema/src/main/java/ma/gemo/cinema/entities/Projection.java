package ma.gemo.cinema.entities;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Projection {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private double prix;
	private Date dateProjection;

	@ManyToOne
	@ToString.Exclude
	@JsonProperty(access = Access.WRITE_ONLY)

	private Salle salle;
	@ManyToOne
	@ToString.Exclude

	private Film film;
	@OneToMany(mappedBy = "projection")
	@ToString.Exclude
	@JsonProperty(access = Access.WRITE_ONLY)

	private Collection<Ticket> tickets;
	@ManyToOne
	@ToString.Exclude

	private Seance seance;
}
