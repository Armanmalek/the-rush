import React, { useEffect, useState } from "react";
import { useTable } from "react-table";
import { CSVLink } from "react-csv";
import { initRushingChannel, sortPlayers } from "./rushingService";

const NflTable = () => {
  const [players, loadPlayers] = useState([]);
  const [search, setSearch] = useState();
  const [sort, loadSort] = useState();

  useEffect(() => {
    const init = async () => {
      const rushingChannel = await initRushingChannel();
      rushingChannel.listen("players", (res) => {
        loadPlayers(res.players);
      });
    };

    init();

    return () => {
      disconnectInstacartOrdersChannel();
    };
  }, []);

  const data = React.useMemo(() => players);

  const columns = React.useMemo(
    () => [
      {
        Header: "Player",
        accessor: "player", // accessor is the "key" in the data
      },
      {
        Header: "Team",
        accessor: "team",
      },
      {
        Header: "Pos",
        accessor: "pos",
      },
      {
        Header: "Att",
        accessor: "att",
      },
      {
        Header: "Att/G",
        accessor: "attg",
      },
      {
        Header: "Yds",
        accessor: "yds",
      },
      {
        Header: "Avg",
        accessor: "avg",
      },
      {
        Header: "Yds/G",
        accessor: "ydsg",
      },
      {
        Header: "TD",
        accessor: "td",
      },
      {
        Header: "Lng",
        accessor: "lng",
      },
      {
        Header: "1st",
        accessor: "first",
      },
      {
        Header: "20+",
        accessor: "twenty",
      },
      {
        Header: "40+",
        accessor: "forty",
      },
      {
        Header: "FUM",
        accessor: "fum",
      },
    ],
    []
  );

  const handleSearchInput = (e) => {
    setSearch(e.target.value);
  };

  const handleSearch = () => {
    sortPlayers({ search: search, sort: sort });
  };

  const handleSort = (e) => {
    loadSort(e.target.value.split(","));
  };

  const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } =
    useTable({ columns, data });

  return (
    <React.Fragment>
      <CSVLink data={players}>Download List</CSVLink>;
      <br />
      <input onChange={handleSearchInput} placeholder="Player name" />
      <label htmlFor="sort">Sort By:</label>
      <select name="sort" id="sort" onChange={handleSort}>
        <option value="none" label=" "></option>
        <option value="desc,yds">Yards Desc</option>
        <option value="asc,yds">Yards Asc</option>
        <option value="desc,td">Touchdowns Desc</option>
        <option value="asc,td">Touchdowns Asc</option>
        <option value="desc,lng">Longest Run Desc</option>
        <option value="asc,lng">Longest Run Asc</option>
      </select>
      <button onClick={handleSearch}>search</button>
      <table {...getTableProps()} style={{ border: "solid 1px blue" }}>
        <thead>
          {headerGroups.map((headerGroup) => (
            <tr {...headerGroup.getHeaderGroupProps()}>
              {headerGroup.headers.map((column) => (
                <th
                  {...column.getHeaderProps()}
                  style={{
                    borderBottom: "solid 3px red",
                    background: "aliceblue",
                    color: "black",
                    fontWeight: "bold",
                  }}
                >
                  {column.render("Header")}
                </th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody {...getTableBodyProps()}>
          {rows.map((row) => {
            prepareRow(row);
            return (
              <tr {...row.getRowProps()}>
                {row.cells.map((cell) => {
                  return (
                    <td
                      {...cell.getCellProps()}
                      style={{
                        padding: "10px",
                        border: "solid 1px gray",
                        background: "papayawhip",
                      }}
                    >
                      {cell.render("Cell")}
                    </td>
                  );
                })}
              </tr>
            );
          })}
        </tbody>
      </table>
    </React.Fragment>
  );
};

export default NflTable;
