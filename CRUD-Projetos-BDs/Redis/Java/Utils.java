package jredis;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.exceptions.JedisConnectionException;

public class Utils {
	
	static Scanner teclado = new Scanner(System.in);
	
	public static String gera_id() {
		Jedis conn = conectar();
		
		String chave = conn.get("chave");
		
		if(chave != null) {
			chave = conn.incr("chave").toString();
						
			return chave;
		} else {
			conn.set("chave", "1");
			
		
			return "1";
		}
		
		desconectar(conn);
	}
	
	public static Jedis conectar() {
		
		Jedis conn = new Jedis("localhost");
		
		return conn;
	}
	
	public static void desconectar(Jedis conn) {
		conn.disconnect();
	}
	public static void listar() {
		Jedis conn = conectar();
		
		try {
			Set<String> res = conn.keys("produtos:*");
			
			if(res.size() > 0) {
				System.out.println("Listando produtos");
				System.out.println("-----------------------------");
				for(String chave: res) {
					Map<String, String> produto = conn.hgetAll(chave);
					System.out.println("ID: " + chave);
					System.out.println("Nome: " + produto.get("nome"));
					System.out.println("Pre�o: " + produto.get("preco"));
					System.out.println("Estoque: " + produto.get("estoque"));
					System.out.println("-----------------------------");
				}
			} else {
				System.out.println("N�o existem produtos cadastrados.");
			}
		} catch (JedisConnectionException e) {
			System.out.println("Verifique se o servidor Redis est� ativo " + e);
		}
		desconectar(conn);
	}
	
	public static void inserir() {
		Jedis conn = conectar();
		
		System.out.println("Informe o nome do produto: ");
		String nome = teclado.nextLine();
		
		System.out.println("Informe o pre�o do produto: ");
		String preco = teclado.nextLine();
		
		System.out.println("Informe o estoque do produto: ");
		String estoque = teclado.nextLine();
		
		Map<String, String> produto = new HashMap<String, String>();
		produto.put("nome", nome);
		produto.put("preco", preco);
		produto.put("estoque", estoque);
		
		String chave = "produtos:" + Utils.gera_id();
		
		try {
			String res = conn.hmset(chave, produto);
			
			if(res != null) {
				System.out.println("O produto " + nome + "foi inserido com sucesso.");
				
			} else {
				System.out.println("N�o foi poss�vel inserir o produto.");
			}
			
		} catch (JedisConnectionException e) {
			System.out.println("Verifique se o Redis est� ativo.");
		}
		desconectar(conn);
	}
	
	public static void atualizar() {
		Jedis conn = conectar();
		
		System.out.println("Informe a chave do produto: ");
		String chave = teclado.nextLine();
		
		System.out.println("Informe o nome do produto: ");
		String nome = teclado.nextLine();
		
		System.out.println("Informe o pre�o do produto: ");
		String preco = teclado.nextLine();
		
		System.out.println("Informe o estoque do produto: ");
		String estoque = teclado.nextLine();
		
		Map<String, String> produto = new HashMap<String, String>();
		produto.put("nome", nome);
		produto.put("preco", preco);
		produto.put("estoque", estoque);
		
		try {
			String res = conn.hmset(chave, produto);
			
			if(res != null) {
				System.out.println("O produto " + nome + "foi atualizado com sucesso.");
				
			} else {
				System.out.println("N�o foi poss�vel atualizar o produto.");
			}
			
		} catch (JedisConnectionException e) {
			System.out.println("Verifique se o Redis est� ativo.");
		}
		desconectar(conn);
		
	}
	
	public static void deletar() {
		Jedis conn = conectar();
		
		System.out.println("Informe a chave do produto: ");
		String chave = teclado.nextLine();
		
		try {
			Long ret = conn.del(chave);
			
			if(ret>0) {
				System.out.println("O produto foi deletado com sucesso.");
			} else {
				System.out.println("O produto p�de ser deletado com a chave informada.");
			}
		} catch (JedisConnectionException e) {
			System.out.println("Verifique se o Redis est� ativo: " + e);
		}
		desconectar(conn);
	}
	
	public static void menu() {
		System.out.println("==================Gerenciamento de Produtos===============");
		System.out.println("Selecione uma opção: ");
		System.out.println("1 - Listar produtos.");
		System.out.println("2 - Inserir produtos.");
		System.out.println("3 - Atualizar produtos.");
		System.out.println("4 - Deletar produtos.");
		
		int opcao = Integer.parseInt(teclado.nextLine());
		if(opcao == 1) {
			listar();
		}else if(opcao == 2) {
			inserir();
		}else if(opcao == 3) {
			atualizar();
		}else if(opcao == 4) {
			deletar();
		}else {
			System.out.println("Opção inválida.");
		}
	}
}
